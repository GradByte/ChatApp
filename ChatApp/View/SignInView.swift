//
//  SignInView.swift
//  ChatApp
//
//  Created by GradByte on 25.01.2024.
//

import SwiftUI

struct SignInView: View {
    @Binding var signInScreenActive: Bool
    @Binding var myUserId: String
    @State var myPassword: String = ""
    @State var returnedAnswer: SigninReturn? = nil
    @State var showAlert = false
    @State var isSheetPresented = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("ChatApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("by GradByte")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                Spacer()
                
                TextField("UserID", text: $myUserId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                    .frame(width: 200)
                    .padding()
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    
                SecureField("Password", text: $myPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                    .frame(width: 200)
                
                Spacer()
                
                Button {
                    signIn(userId: myUserId , password: myPassword)
                    
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                        .frame(width: 240, height: 40)
                        .padding()
                }
                
                Button {
                    // Set the state variable to true to present the sheet
                    isSheetPresented.toggle()
                } label: {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8941176534, green: 0.9529411793, blue: 0.890196084, alpha: 1)), Color(#colorLiteral(red: 0.360784322, green: 0.6627451181, blue: 0.9137254953, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                        .frame(width: 240, height: 40)
                        .padding()
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Invalid Credentials"),
                        message: Text("\(returnedAnswer?.message ?? "Something is wrong!")"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                //sign up sheet
                .sheet(isPresented: $isSheetPresented) {
                    SignUpView(isSheetPresented: $isSheetPresented)
                }
                
                
                Spacer()
            }
        }
    }
    
    func signIn(userId: String, password: String) {
        guard let url = URL(string: "http://localhost:3000/sign-in") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let credential = Credential(userId: userId, password: password)
        
        print(credential)
        
        do {
            request.httpBody = try JSONEncoder().encode(credential)
            
        } catch {
            print("Error encoding JSON body: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(SigninReturn.self, from: data)
                DispatchQueue.main.async {
                    self.returnedAnswer = decodedData
                    
                    if self.returnedAnswer?.success == true {
                        self.signInScreenActive.toggle()
                    }
                    else {
                        self.showAlert = true
                        self.myPassword = ""
                    }
                    
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        }.resume()
        
    }
}

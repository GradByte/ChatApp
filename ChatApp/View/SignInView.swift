//
//  SignInView.swift
//  ChatApp
//
//  Created by GradByte on 25.01.2024.
//

import SwiftUI

struct SignInView: View {
    @Binding var signInScreenActive: Bool
    @Binding var myUserId: Int
    @State var myPassword: String = ""
    @State var returnedAnswer: SigninReturn? = nil
    @State private var showAlert = false
    
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
                
                TextField("UserID", value: $myUserId, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(width: 200)
                    .padding()
                
                SecureField("Password", text: $myPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                    .frame(width: 200)
                
                Spacer()
                
                Button {
                    signIn(userId: myUserId ?? 1, password: myPassword)
                    
                } label: {
                    Text("Sign In!")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                }
                .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Invalid Credentials"),
                                    message: Text("\(returnedAnswer?.message ?? "Something is wrong!")"),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                
                Spacer()
            }
        }
    }
    
    func signIn(userId: Int, password: String) {
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

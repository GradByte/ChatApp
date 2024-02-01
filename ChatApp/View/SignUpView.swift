//
//  SignUpView.swift
//  ChatApp
//
//  Created by GradByte on 26.01.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @State var myUserId: String = ""
    @State var myPassword: String = ""
    @State var returnedAnswer: SigninReturn? = nil
    @State private var showAlert = false
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.360784322, green: 0.6627451181, blue: 0.9137254953, alpha: 1)), Color(#colorLiteral(red: 0.8941176534, green: 0.9529411793, blue: 0.890196084, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                
                Text("Sign-Up Page")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                
                TextField("UserID", text: $myUserId)
                    .modifier(TextFieldViewModifier())
                
                SecureField("Password", text: $myPassword)
                    .modifier(TextFieldViewModifier())
                
                Spacer()
                
                Button {
                    signUp(userId: myUserId, password: myPassword)
                    
                } label: {
                    Text("Sign-Up")
                        .modifier(ButtonViewModifier())
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Sign Up Failed!"),
                        message: Text("\(returnedAnswer?.message ?? "Something is wrong!")"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                Spacer()
            }
        }
    }
    
    func signUp(userId: String, password: String) {
        guard let url = URL(string: "http://localhost:3000/sign-up") else {
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
                        self.isSheetPresented.toggle()
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

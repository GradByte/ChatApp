//
//  SignInView.swift
//  ChatApp
//
//  Created by GradByte on 25.01.2024.
//

import SwiftUI

struct SignInView: View {
    @Binding var signInScreenActive: Bool
    @Binding var myUserId: Int?
    @State var myPassword: String = ""
    
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
                    signInScreenActive.toggle()
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
                
                Spacer()
            }
        }
    }
}

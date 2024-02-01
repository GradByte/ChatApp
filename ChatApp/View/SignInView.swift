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
    @State private var myPassword: String = ""
    @ObservedObject var viewModel = ViewModel()
    
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
                    .modifier(TextFieldViewModifier())
                    
                SecureField("Password", text: $myPassword)
                    .modifier(TextFieldViewModifier())
                
                Spacer()
                
                Button {
                    viewModel.signIn(userId: myUserId, password: myPassword)
                    myPassword = ""
                    
                } label: {
                    Text("Sign-In")
                        .modifier(ButtonViewModifier())
                }
                
                Button {
                    viewModel.isSheetPresented.toggle()
                } label: {
                    Text("Sign-Up")
                        .modifier(ButtonViewModifier())

                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Invalid Credentials"),
                        message: Text("\(viewModel.returnedAnswer?.message ?? "Something is wrong!")"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                //sign up sheet
                .sheet(isPresented: $viewModel.isSheetPresented) {
                    SignUpView(isSheetPresented: $viewModel.isSheetPresented)
                }
                
                Spacer()
            }
        }
        .onChange(of: viewModel.signInScreenActive) { newParameter in
            signInScreenActive = newParameter
        }
    }
}

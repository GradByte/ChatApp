//
//  SignUpView.swift
//  ChatApp
//
//  Created by GradByte on 26.01.2024.
//

import SwiftUI

struct SignUpView: View {
    //ObservedObject because SignInView.ViewModel is used in multiple views.
    @ObservedObject var signInViewModel: SignInView.ViewModel
    //StateObject because SignUpView.ViewModel is only used in this view.
    @StateObject var viewModel = ViewModel()
    
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
                
                TextField("UserID", text: $viewModel.myUserId)
                    .modifier(TextFieldViewModifier())
                
                SecureField("Password", text: $viewModel.myPassword)
                    .modifier(TextFieldViewModifier())
                
                Spacer()
                
                Button {
                    viewModel.signUp()
                    
                } label: {
                    Text("Sign-Up")
                        .modifier(ButtonViewModifier())
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Sign Up Failed!"),
                        message: Text("\(viewModel.returnedAnswer?.message ?? "Something is wrong!")"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                Spacer()
            }
        }
        .onChange(of: viewModel.isSheetPresented) { newParam in
            signInViewModel.isSheetPresented = newParam
        }
    }
}

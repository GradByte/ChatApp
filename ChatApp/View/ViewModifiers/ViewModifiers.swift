//
//  ViewModifiers.swift
//  ChatApp
//
//  Created by GradByte on 1.02.2024.
//

import Foundation
import SwiftUI

struct ButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .padding(.horizontal, 20)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.360784322, green: 0.6627451181, blue: 0.9137254953, alpha: 1)), Color(#colorLiteral(red: 0.8941176534, green: 0.9529411793, blue: 0.890196084, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
            .frame(width: 240, height: 40)
            .padding()
    }
}

struct TextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.default)
            .frame(width: 200)
            .padding()
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
    }
}

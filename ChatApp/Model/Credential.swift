//
//  Credential.swift
//  ChatApp
//
//  Created by GradByte on 25.01.2024.
//

import Foundation

struct Credential: Codable {
    let userId: String
    let password: String
}

struct SigninReturn: Codable {
    var id = UUID()
    let success: Bool
    let message: String
}

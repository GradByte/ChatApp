//
//  Credential.swift
//  ChatApp
//
//  Created by GradByte on 25.01.2024.
//

import Foundation

struct Credential: Encodable {
    let userId: String
    let password: String
}

struct SigninReturn: Decodable {
    let id = UUID()
    let success: Bool
    let message: String
}

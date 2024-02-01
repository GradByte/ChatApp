//
//  Message.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import Foundation

//get-messages return
struct Message: Codable, Hashable {
    var id: Int
    let senderId: String
    let receiverId: String
    let message: String
}

//get-messages
struct GetMessage: Codable {
    let senderId: String
    let receiverId: String
}

//send-message
struct SendMessage: Encodable {
    let senderId: String
    let receiverId: String
    let message: String
}


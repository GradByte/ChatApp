//
//  Chat.swift
//  ChatApp
//
//  Created by GradByte on 27.01.2024.
//

import Foundation

struct Chat: Codable, Hashable {
    let receiverId: String
}

//Send this to server and server will return you ReceivedChats
struct GetChats: Codable {
    let senderId: String
}

//Server's response for GetChats
//[String] - ids we are currently have chat

//Send this to server and server will return you ReceivedChats
//Because new chat is added.
struct AddChat: Codable {
    let senderId: String
    let receiverId: String
}

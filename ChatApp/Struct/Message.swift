//
//  Message.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import Foundation

struct Message: Hashable {
    var id = UUID()
    var content: String
    var myMessage: Bool
    
    static let example = Message(content: "Hey, how are you?", myMessage: true)
}

struct Item: Decodable, Hashable {
    var id: Int
    let senderId: Int
    let message: String
}

struct OngoingMessage: Encodable {
    let senderId: Int
    let message: String
}

struct ExampleMessages {
    static let messages = [
        Message(content: "Hey, welcome!", myMessage: false),
        Message(content: "Hi there! How's it going?", myMessage: true),
        Message(content: "Thanks for the warm welcome!", myMessage: false),
        Message(content: "Doing well, thanks! What brings you here?", myMessage: true),
        Message(content: "Just exploring the platform. It looks interesting!", myMessage: false),
        Message(content: "Absolutely! There's a lot to discover. Any specific interests?", myMessage: true),
        Message(content: "I'm into coding and technology. How about you?", myMessage: false),
        Message(content: "Nice! I'm a fellow tech enthusiast too. What languages do you code in?", myMessage: true),
        Message(content: "Primarily in Swift and Python. How about you?", myMessage: false),
        Message(content: "I'm more into Java and JavaScript. Cool mix! 😊", myMessage: true),
        Message(content: "Hey, welcome!", myMessage: false),
        Message(content: "Hi there! How's it going?", myMessage: true),
        Message(content: "Thanks for the warm welcome!", myMessage: false),
        Message(content: "Doing well, thanks! What brings you here?", myMessage: true),
        Message(content: "Just exploring the platform. It looks interesting!", myMessage: false),
        Message(content: "Absolutely! There's a lot to discover. Any specific interests?", myMessage: true),
        Message(content: "I'm into coding and technology. How about you?", myMessage: false),
        Message(content: "Nice! I'm a fellow tech enthusiast too. What languages do you code in?", myMessage: true),
        Message(content: "Primarily in Swift and Python. How about you?", myMessage: false)
    ]
}

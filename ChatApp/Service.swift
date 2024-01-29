//
//  Service.swift
//  ChatApp
//
//  Created by GradByte on 29.01.2024.
//

import Foundation
import SocketIO

final class GetMessageService: ObservableObject {
    private var manager = SocketManager(socketURL: URL(string: "ws://localhost:3000")!, config: [.log(false), .compress])
    
    @Published var message: Message? = nil
    
    init(senderId: String, receiverId: String) {
        let socket = manager.defaultSocket

        socket.on(clientEvent: .connect) { (data, ack) in
            print("GetMessage-Socket connected")
        }

        socket.on("\(senderId)-getMessage") { [weak self] (data, ack) in
            print("Message received")
            print(data[0])

            if let messageData = data[0] as? [String: Any],
               let id = messageData["id"] as? Int,
               let senderId = messageData["senderId"] as? String,
               let receiverId = messageData["receiverId"] as? String,
               let messageContent = messageData["message"] as? String {

                let receivedMessage = Message(id: id, senderId: senderId, receiverId: receiverId, message: messageContent)

                DispatchQueue.main.async {
                    self?.message = receivedMessage
                    print(receivedMessage.message)
                }
            }
        }

        socket.connect()
    }
}

final class SendMessageService: ObservableObject {
    private var manager: SocketManager
    private var socket: SocketIOClient

    @Published var isConnected: Bool = false

    init() {
        manager = SocketManager(socketURL: URL(string: "ws://localhost:3000")!, config: [.log(false), .compress])
        socket = manager.defaultSocket

        setupSocket()
    }

    private func setupSocket() {
        socket.on(clientEvent: .connect) { (data, ack) in
            print("Connected to socket")
            self.isConnected = true
        }

        socket.on(clientEvent: .disconnect) { (data, ack) in
            print("Disconnected from socket")
            self.isConnected = false
        }

        socket.connect()
    }

    func sendMessage(message: SendMessage) {
        // Check if the socket is connected before trying to send a message
        guard isConnected else {
            print("Socket is not connected.")
            return
        }

        // Emit the message to the server
        socket.emit("SendMessage-Server", ["senderId":"\(message.senderId)", "receiverId":"\(message.receiverId)", "message":"\(message.message)"])
    }

    deinit {
        // Disconnect the socket when the service is deallocated
        socket.disconnect()
    }
}

/**
final class Service: ObservableObject {
    private var manager = SocketManager(socketURL: URL(string: "ws://localhost:3000")!, config: [.log(true), .compress])
    
    @Published var messages = [String]()
    
    init() {
        let socket = manager.defaultSocket
        socket.on(clientEvent: .connect) { (data, ack) in
            print("connected")
            socket.emit("NodeJS Server Port", "Hi NodeJS Server!!!")
        }
        
        socket.on("iOS Client Port") { [weak self] (data, ack) in
            if let data = data[0] as? [String: String],
               let rawMessage = data["msg"] {
                DispatchQueue.main.async {
                    self?.messages.append(rawMessage)
                }
            }
        }
        
        socket.connect()
    }
}
*/

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
            //print("GetMessage-Socket connected")
        }

        socket.on("\(senderId)-getMessage") { [weak self] (data, ack) in
            //print("Message received")
            //print(data[0])

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
            //print("Connected to socket")
            self.isConnected = true
        }

        socket.on(clientEvent: .disconnect) { (data, ack) in
            //print("Disconnected from socket")
            self.isConnected = false
        }

        socket.connect()
    }

    func sendMessage(message: SendMessage) {
        // Check if the socket is connected before trying to send a message
        guard isConnected else {
            //print("Socket is not connected.")
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

final class GetChatsService: ObservableObject {
    private var manager = SocketManager(socketURL: URL(string: "ws://localhost:3000")!, config: [.log(false), .compress])
    
    @Published var chat: String = ""
    
    init(senderId: String) {
        let socket = manager.defaultSocket

        socket.on(clientEvent: .connect) { (data, ack) in
            print("GetChats-Socket connected")
        }

        socket.on("\(senderId)-getChats") { [weak self] (data, ack) in
            print("Message received")
            print(data[0])

            if let messageData = data[0] as? [String: Any],
               let newChat = messageData["chat"] as? String {
                DispatchQueue.main.async {
                    self?.chat = newChat
                    print(newChat)
                }
            }
        }

        socket.connect()
    }
}

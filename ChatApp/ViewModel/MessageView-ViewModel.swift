//
//  MessageView-ViewModel.swift
//  ChatApp
//
//  Created by GradByte on 2.02.2024.
//

import Foundation

extension MessageView {
    class ViewModel: ObservableObject {
        @Published var messages = [Message]()
        @Published var newMessage: String = ""
        
        func askSendMessage(senderId: String, receiverId: String) {
            if !newMessage.isEmpty{
                sendMessage(senderId: senderId, receiverId: receiverId, message: newMessage)
                newMessage = ""
            }
        }
        
        func getMessages(senderId: String, receiverId: String) {
            guard let url = URL(string: "http://localhost:3000/get-messages") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let conversationWith = GetMessage(senderId: senderId, receiverId: receiverId)
            
            do {
                request.httpBody = try JSONEncoder().encode(conversationWith)
                
            } catch {
                print("Error encoding JSON body: \(error)")
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode([Message].self, from: data)
                    DispatchQueue.main.async {
                        self.messages = decodedData
                        
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
                
            }.resume()
            
        }
        
        
        func sendMessage(senderId: String, receiverId: String, message: String) {
            guard let url = URL(string: "http://localhost:3000/send-message") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let newMessage = SendMessage(senderId: senderId, receiverId: receiverId, message: message)
            
            do {
                request.httpBody = try JSONEncoder().encode(newMessage)
            } catch {
                print("Error encoding JSON body: \(error)")
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle the response or error here
                // You can update the UI or perform additional actions if needed
            }.resume()
            
            //fetch to update messages
            self.getMessages(senderId: senderId, receiverId: receiverId)
        }
    }
}

//
//  ChatsView-ViewModel.swift
//  ChatApp
//
//  Created by GradByte on 2.02.2024.
//

import Foundation

extension ChatsView {
    class ViewModel: ObservableObject {
        @Published var receiverId: String = ""
        @Published var showAlert = false
        @Published var userInput = ""
        @Published var searchText = ""
        @Published var chats: [String] = []
        
        
        func submit(myUserId: String) {
            addChat(myUserId: myUserId)
            showAlert.toggle()
        }
        
        func getChats(myUserId: String) {
            guard let url = URL(string: "http://localhost:3000/get-chats") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let myChats = GetChats(senderId: myUserId)
            
            do {
                request.httpBody = try JSONEncoder().encode(myChats)
                
            } catch {
                print("Error encoding JSON body: \(error)")
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode([String].self, from: data)
                    DispatchQueue.main.async { [weak self] in
                        self?.chats = decodedData
                        
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
                
            }.resume()
            
        }
        
        func addChat(myUserId: String) {
            guard let url = URL(string: "http://localhost:3000/add-chat") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let newChat = AddChat(senderId: myUserId, receiverId: receiverId)
            
            do {
                request.httpBody = try JSONEncoder().encode(newChat)
                
            } catch {
                print("Error encoding JSON body: \(error)")
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode([String].self, from: data)
                    DispatchQueue.main.async {
                        self.chats = decodedData
                        print(self.chats)
                        
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
                
            }.resume()
            
            self.getChats(myUserId: myUserId)
        }
        
        var searchResults: [String] {
            if searchText.isEmpty {
                return chats
            } else {
                return chats.filter { $0.contains(searchText) }
            }
        }
    }
}

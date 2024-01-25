//
//  NodejsSendView.swift
//  ChatApp
//
//  Created by GradByte on 25.01.2024.
//

import SwiftUI
import Combine

struct NodejsSendView: View {
    @State private var messages = [Item]()
    @State var newMessage: String = ""
    
    
    var body: some View {
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(messages, id: \.id) { item in
                            MessageCell(message: item.message, myMessage: (item.senderId == 1))
                        }
                    }
                    .onReceive(Just(messages)) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                        
                    }.onAppear {
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                    }
                }
                
                // send new message
                HStack {
                    TextField("Send a message", text: $newMessage)
                        .textFieldStyle(.roundedBorder)
                    Button(action: sendMessage)   {
                        Image(systemName: "paperplane")
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Name")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            callFunc()
        }
        
        
        
    }
    
    func callFunc() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                //print("-----> callFunc")
                self.fetchItems()
                callFunc()
            }
        }
    
    func sendMessage() {
        
        if !newMessage.isEmpty{
            addItem(senderId: 1, message: newMessage)
            newMessage = ""
        }
    }
    
    func fetchItems() {
        guard let url = URL(string: "http://localhost:3000/messages") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Item].self, from: data)
                DispatchQueue.main.async {
                    self.messages = decodedData
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func addItem(senderId: Int, message: String) {
        guard let url = URL(string: "http://localhost:3000/send-message") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let newMessage = OngoingMessage(senderId: senderId, message: message)

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
        self.fetchItems()
    }
}

#Preview {
    NodejsSendView()
}

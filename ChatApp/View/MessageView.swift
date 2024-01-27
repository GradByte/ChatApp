//
//  MessageView.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import SwiftUI
import Combine

struct MessageView: View {
    //@State var messages = ExampleMessages.messages
    @State private var messages = [Message]()
    @State var newMessage: String = ""
    @State var myId: String
    @State var receiverId: String
    
    
    var body: some View {
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(messages, id: \.id) { item in
                            MessageCell(message: item.message, myMessage: (item.senderId == myId))
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
                        .autocorrectionDisabled(true)
    
                    Button(action: askSendMessage)   {
                        Image(systemName: "paperplane")
                    }
                }
                .padding()
            }
        }
        .navigationTitle("\(receiverId)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            callFunc()
        }
        
        
        
    }
    
    //Get messages every second
    func callFunc() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.getMessages(senderId: self.myId, receiverId: self.receiverId)
            callFunc()
        }
    }
    
    func askSendMessage() {
        
        if !newMessage.isEmpty{
            self.sendMessage(senderId: self.myId, receiverId: self.receiverId, message: self.newMessage)
            self.newMessage = ""
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

#Preview {
    MessageView(myId: "paul", receiverId: "john")
}

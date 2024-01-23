//
//  ChatView.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import SwiftUI
import Combine

struct ChatView: View {
    @State var messages = ExampleMessages.messages
    @State var newMessage: String = ""
    
    
    var body: some View {
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(messages, id: \.self) { message in
                            MessageView(currentMessage: message)
                                .id(message)
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
        
        
        
    }
    
    func sendMessage() {
        
        if !newMessage.isEmpty{
            messages.append(Message(content: newMessage, myMessage: true))
            messages.append(Message(content: "Reply of " + newMessage , myMessage: false))
            newMessage = ""
        }
    }
}

#Preview {
    ChatView()
}

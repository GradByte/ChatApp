//
//  MessageView.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import SwiftUI
import Combine

struct MessageView: View {
    @StateObject var viewModel = ViewModel()
    @ObservedObject var contentViewModel : ContentView.ViewModel
    @State var receiverId: String
    @ObservedObject var getMessageService: GetMessageService
    @StateObject var sendMessageService = SendMessageService()
    
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages, id: \.id) { item in
                            MessageCell(message: item.message, myMessage: (item.senderId == contentViewModel.myUserId))
                        }
                    }
                    .onAppear {
                        proxy.scrollTo(viewModel.messages.last, anchor: .bottom)
                    }
                }
                .onChange(of: viewModel.messages) { _ in
                    // Scroll to the end whenever messages are updated
                    withAnimation {
                        proxy.scrollTo(viewModel.messages.count - 1, anchor: .bottom)
                    }
                }
                
                // send new message
                HStack {
                    TextField("Send a message", text: $viewModel.newMessage)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled(true)
    
                    Button {
                        sendMessageService.sendMessage(message: SendMessage(senderId: contentViewModel.myUserId, receiverId: receiverId, message: viewModel.newMessage))
                        viewModel.newMessage = ""
                    } label : {
                        Image(systemName: "paperplane")
                    }
                }
                .padding()
            }
        }
        .navigationTitle("\(receiverId)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getMessages(senderId: contentViewModel.myUserId, receiverId: receiverId)
        }
        .onChange(of: getMessageService.message) { newMessage in
            if let new = newMessage {
                viewModel.messages.append(new)
            }
        }
        
    }
}

#Preview {
    MessageView(contentViewModel: ContentView.ViewModel(signInScreenActive: false, myUserId: "paul"), receiverId: "john", getMessageService: GetMessageService(senderId: "paul", receiverId: "john"))
}

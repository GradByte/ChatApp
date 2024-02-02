//
//  ChatsView.swift
//  ChatApp
//
//  Created by GradByte on 27.01.2024.
//

import SwiftUI

struct ChatsView: View {
    @ObservedObject var contentViewModel: ContentView.ViewModel
    @ObservedObject var getChatsService: GetChatsService
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Section (header: GroupedListHeader(), footer: GroupedListFooter()) {
                        ForEach(viewModel.searchResults, id: \.self) { name in
                            VStack {
                                NavigationLink(destination: MessageView(contentViewModel: contentViewModel ,receiverId: name, getMessageService: GetMessageService(senderId: contentViewModel.myUserId, receiverId: name))) {
                                    MenuCell(receiverId: name)
                                }
                            }
                        }.onDelete(perform: self.deleteItem)
                    }
                }.listStyle(GroupedListStyle())
                    .navigationTitle("ChatApp")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        viewModel.showAlert.toggle()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Log Out") {
                        contentViewModel.signInScreenActive.toggle()
                    }
                    .foregroundColor(.red)
                }
            }
            .alert("Enter UserID to start chat!", isPresented: $viewModel.showAlert) {
                TextField("UserID", text: $viewModel.userInput)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                Button {
                    viewModel.submit(myUserId: contentViewModel.myUserId)
                } label : {
                    Text("OK")
                }
                Button("Cancel", role: .cancel) { }
                    }
        }
        .searchable(text: $viewModel.searchText)
        .onAppear {
            viewModel.getChats(myUserId: contentViewModel.myUserId)
        }
        .onChange(of: getChatsService.chat) { newChat in
            viewModel.chats.append(newChat)
        }
        
    }
    
    private func deleteItem(at indexSet: IndexSet) {
        //self.data.remove(atOffsets: indexSet)
    }
}

#Preview {
    ChatsView(contentViewModel: ContentView.ViewModel(signInScreenActive: true, myUserId: "john"), getChatsService: GetChatsService(senderId: "john"))
}

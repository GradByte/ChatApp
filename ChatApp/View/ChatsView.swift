//
//  ChatsView.swift
//  ChatApp
//
//  Created by GradByte on 27.01.2024.
//

import SwiftUI

struct ChatsView: View {
    @State var myUserId: String
    @State var receiverId: String = ""
    @State private var showAlert = false
    @State private var userInput = ""
    @State private var searchText = ""
    @State private var chats: [String] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    Section (header: GroupedListHeader(), footer: GroupedListFooter()) {
                        ForEach(searchResults, id: \.self) { name in
                            VStack {
                                NavigationLink(destination: MessageView(myId: myUserId, receiverId: name, getMessageService: GetMessageService(senderId: myUserId, receiverId: name))) {
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
                        showAlert.toggle()
                    }
                }
            }
            .alert("Enter UserID to start chat!", isPresented: $showAlert) {
                        TextField("UserID", text: $userInput)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                        Button("OK", action: submit)
                        Button("Cancel", role: .cancel) { }
                    }
        }
        .searchable(text: $searchText)
        .onAppear {
            getChats(senderId: myUserId)
            //callFunc()
        }
        
    }
    
    private func deleteItem(at indexSet: IndexSet) {
        //self.data.remove(atOffsets: indexSet)
    }
    
    //Get chats every 3 seconds
    func callFunc() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.getChats(senderId: self.myUserId)
            callFunc()
        }
    }
    
    func submit() {
        addChat(senderId: myUserId, receiverId: userInput)
        showAlert.toggle()
    }
    
    func getChats(senderId: String) {
        guard let url = URL(string: "http://localhost:3000/get-chats") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let myChats = GetChats(senderId: senderId)
        
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
                DispatchQueue.main.async {
                    self.chats = decodedData
                    print(self.chats)
                    
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        }.resume()
        
    }
    
    func addChat(senderId: String, receiverId: String) {
        guard let url = URL(string: "http://localhost:3000/add-chat") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newChat = AddChat(senderId: senderId, receiverId: receiverId)
        
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
        
        self.getChats(senderId: myUserId)
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return chats
        } else {
            return chats.filter { $0.contains(searchText) }
        }
    }
}

#Preview {
    ChatsView(myUserId: "john")
}

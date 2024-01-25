//
//  ContentView.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State var signInScreenActive = true
    @State var myUserId: Int = 0
    @State private var searchText = ""
    //@State var data = ExamplePeople.people
    @State var data = [PeopleItem(name: "John Doe", lastMessage: "Where are you bro?", profilePic: "avatar")]
    
    var body: some View {
        signInScreenActive ?
        AnyView(SignInView(signInScreenActive: $signInScreenActive, myUserId: $myUserId)
            .preferredColorScheme(.light)) :
        AnyView (
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                .edgesIgnoringSafeArea(.all)
                    
                    List {
                        Section (header: GroupedListHeader(), footer: GroupedListFooter()) {
                            ForEach(searchResults, id: \.self) { people in
                                VStack {
                                    NavigationLink(destination: MessageView(myId: myUserId)) {
                                        MenuCell(people: people)
                                    }
                                }
                            }.onDelete(perform: self.deleteItem)
                        }
                    }.listStyle(GroupedListStyle())
                        .navigationTitle("ChatApp")
                }
            }
            .searchable(text: $searchText)
        )
    }
    
    private func deleteItem(at indexSet: IndexSet) {
        //self.data.remove(atOffsets: indexSet)
    }
    
    var searchResults: [PeopleItem] {
            if searchText.isEmpty {
                return data
            } else {
                return data.filter { $0.name.contains(searchText) }
            }
        }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    var data = [
        PeopleItem(name: "John Doe", lastMessage: "Where are you bro?", profilePic: "avatar"),
        PeopleItem(name: "Jane Smith", lastMessage: "Hey there!", profilePic: "avatar"),
        PeopleItem(name: "Alice Johnson", lastMessage: "What's up?", profilePic: "avatar"),
        PeopleItem(name: "Bob Miller", lastMessage: "How's it going?", profilePic: "avatar"),
        PeopleItem(name: "Olivia Smith", lastMessage: "Long time no see!", profilePic: "avatar"),
        PeopleItem(name: "Liam Anderson", lastMessage: "How's work going?", profilePic: "photo"),
        PeopleItem(name: "Emma White", lastMessage: "Planning a trip soon?", profilePic: "image"),
        PeopleItem(name: "Daniel Taylor", lastMessage: "Just finished a great book!", profilePic: "picture"),
        PeopleItem(name: "Eva Brown", lastMessage: "What are your plans for the weekend? Also return me asap!", profilePic: "photo"),
        PeopleItem(name: "Michael Johnson", lastMessage: "Meeting at 3 PM, don't forget!", profilePic: "image"),
        PeopleItem(name: "Sophia Davis", lastMessage: "How's the weather there?", profilePic: "picture"),
        PeopleItem(name: "David Wilson", lastMessage: "Did you see that movie?", profilePic: "avatar")
        
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section (header: GroupedListHeader(), footer: GroupedListFooter()) {
                    ForEach(searchResults, id: \.self) { people in
                        VStack {
                            NavigationLink(destination: MessageView()) {
                                MenuCell(people: people)
                            }
                        }
                    }.onDelete(perform: self.deleteItem)
                }
            }.listStyle(GroupedListStyle())
                .navigationTitle("ChatApp")
        }
        .searchable(text: $searchText)
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

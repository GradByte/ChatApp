//
//  ContentView.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State var data = ExamplePeople.people
    
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

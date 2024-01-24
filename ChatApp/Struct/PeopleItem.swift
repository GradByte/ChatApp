//
//  PeopleItem.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import Foundation
import SwiftUI

struct PeopleItem: Identifiable,Hashable {
    var id = UUID()
    var name: String
    var lastMessage: String
    var profilePic: String
    
    static let example = PeopleItem(name: "John Doe", lastMessage: "Hey! Where are you??", profilePic: "profile.circle")
}

struct ExamplePeople {
    static let people = [
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
}

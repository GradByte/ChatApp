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

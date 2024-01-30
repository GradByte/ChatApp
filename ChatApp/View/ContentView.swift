//
//  ContentView.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State var signInScreenActive = true
    @State var myUserId: String = ""
    
    var body: some View {
        signInScreenActive ?
        AnyView(SignInView(signInScreenActive: $signInScreenActive, myUserId: $myUserId)
            .preferredColorScheme(.light)) :
        AnyView (
            ChatsView(signInScreenActive: $signInScreenActive, myUserId: myUserId, getChatsService: GetChatsService(senderId: myUserId))
        )
    }
    
    
}

#Preview {
    ContentView()
}

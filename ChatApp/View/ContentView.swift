//
//  ContentView.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        viewModel.signInScreenActive ?
        AnyView(SignInView(contentViewModel: viewModel)
            .preferredColorScheme(.light)) :
        AnyView (
            ChatsView(contentViewModel: viewModel, getChatsService: GetChatsService(senderId: viewModel.myUserId))
        )
    }
}

#Preview {
    ContentView()
}

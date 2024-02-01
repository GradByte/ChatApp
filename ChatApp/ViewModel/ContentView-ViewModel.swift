//
//  ContentView-ViewModel.swift
//  ChatApp
//
//  Created by GradByte on 1.02.2024.
//

import Foundation

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var signInScreenActive = true
        @Published var myUserId: String = ""
    }
}

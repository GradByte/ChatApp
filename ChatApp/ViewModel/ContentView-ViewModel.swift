//
//  ContentView-ViewModel.swift
//  ChatApp
//
//  Created by GradByte on 2.02.2024.
//

import Foundation

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var signInScreenActive = true
        @Published var myUserId: String = ""
        
        init(signInScreenActive: Bool = true, myUserId: String = "") {
            self.signInScreenActive = signInScreenActive
            self.myUserId = myUserId
        }
    }
}

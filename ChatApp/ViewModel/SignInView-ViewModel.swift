//
//  SignInView-ViewModel.swift
//  ChatApp
//
//  Created by GradByte on 1.02.2024.
//

import Foundation

extension SignInView {
    class ViewModel: ObservableObject {
        
        @Published var signInScreenActive = true
        @Published var returnedAnswer: SigninReturn? = nil
        @Published var showAlert = false
        @Published var isSheetPresented = false
        
        //try to sign in with myUserId and myPassword
        func signIn(userId: String, password: String) {
            guard let url = URL(string: "http://localhost:3000/sign-in") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let credential = Credential(userId: userId, password: password)
            
            print(credential)
            
            do {
                request.httpBody = try JSONEncoder().encode(credential)
                
            } catch {
                print("Error encoding JSON body: \(error)")
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(SigninReturn.self, from: data)
                    DispatchQueue.main.async { [weak self] in
                        
                        self?.returnedAnswer = decodedData
                        
                        if self?.returnedAnswer?.success == true {
                            self?.signInScreenActive.toggle()
                        }
                        else {
                            self?.showAlert = true
                        }
                        
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
                
            }.resume()
            
        }
    }
}

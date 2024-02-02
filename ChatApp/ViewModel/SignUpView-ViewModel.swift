//
//  SignUpView-ViewModel.swift
//  ChatApp
//
//  Created by GradByte on 2.02.2024.
//

import Foundation

extension SignUpView {
    class ViewModel: ObservableObject {
        @Published var myUserId: String = ""
        @Published var myPassword: String = ""
        @Published var returnedAnswer: SigninReturn? = nil
        @Published var showAlert = false
        @Published var isSheetPresented = true
        
        func signUp() {
            guard let url = URL(string: "http://localhost:3000/sign-up") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let credential = Credential(userId: myUserId, password: myPassword)
            
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
                            self?.isSheetPresented = false
                        }
                        else {
                            self?.showAlert = true
                            self?.myPassword = ""
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
                
            }.resume()
            
        }
    }
}

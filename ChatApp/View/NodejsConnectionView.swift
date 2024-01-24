//
//  NodejsConnectionView.swift
//  ChatApp
//
//  Created by GradByte on 24.01.2024.
//

import SwiftUI

struct NodejsConnectionView: View {
    @State private var items = [String]()
    
    var body: some View {
        VStack {
            List(items, id: \.self) { item in
                Text(item)
            }
            .padding()
            
            Button("Fetch Items") {
                fetchItems()
            }
            .padding()
        }
    }
    
    func fetchItems() {
        guard let url = URL(string: "http://localhost:3000/hello") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([String].self, from: data)
                DispatchQueue.main.async {
                    self.items = decodedData
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

#Preview {
    NodejsConnectionView()
}

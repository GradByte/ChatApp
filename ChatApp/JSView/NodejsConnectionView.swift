////
////  NodejsConnectionView.swift
////  ChatApp
////
////  Created by GradByte on 24.01.2024.
////
//
//import SwiftUI
//
//struct NodejsConnectionView: View {
//    @State private var items = [Item]()
//    
//    var body: some View {
//        VStack {
//            List(items, id: \.id) { item in
//                VStack(alignment: .leading) {
//                    Text("Message: \(item.message)")
//                    Text("Sender ID: \(item.senderId)")
//                }
//            }
//            .padding()
//            
//            Button("Fetch Items") {
//                fetchItems()
//            }
//            .padding()
//        }
//    }
//    
//    func fetchItems() {
//        guard let url = URL(string: "http://localhost:3000/messages") else {
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            
//            do {
//                let decodedData = try JSONDecoder().decode([Item].self, from: data)
//                DispatchQueue.main.async {
//                    self.items = decodedData
//                }
//            } catch {
//                print("Error decoding JSON: \(error)")
//            }
//        }.resume()
//    }
//}
//
//#Preview {
//    NodejsConnectionView()
//}

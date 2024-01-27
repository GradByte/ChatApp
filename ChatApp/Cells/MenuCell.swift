//
//  MenuCell.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import SwiftUI

struct MenuCell: View {
    @State var receiverId: String
    
    var body: some View {
        HStack{
            Image("ppImage")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 8) {
                Text(receiverId)
                    .bold()
                    .font(.subheadline)
                    .lineLimit(1)
                Text("Let's talk privately!")
                    .font(.subheadline)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    MenuCell(receiverId: "paul")
}

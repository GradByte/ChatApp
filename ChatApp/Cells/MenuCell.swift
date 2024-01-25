//
//  MenuCell.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import SwiftUI

struct MenuCell: View {
    @State var people: PeopleItem
    
    var body: some View {
        HStack{
            Image(systemName:"person.circle")
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 8) {
                Text(people.name)
                    .bold()
                    .font(.subheadline)
                    .lineLimit(1)
                Text(people.lastMessage)
                    .font(.subheadline)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    MenuCell(people: PeopleItem.example)
}

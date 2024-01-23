//
//  MessageCell.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import SwiftUI

struct MessageCell: View {
    @State var message: String
    @State var myMessage: Bool
    
    var body: some View {
        
        Text(message)
            .bold()
            .padding(10)
            .foregroundColor(myMessage ? .white : .black)
            .background(myMessage ? Color.blue : Color(UIColor.lightGray))
            .cornerRadius(20)
            .frame(maxWidth: .infinity, alignment: (myMessage ? .trailing : .leading))
            .padding([.trailing, .leading], 20)
            .padding([.top], 10)
        
    }
}

#Preview {
    VStack {
        MessageCell(message: "I'm here, and alive!", myMessage: true)
        MessageCell(message: "I'm here, and alive!", myMessage: true)
        MessageCell(message: "I'm here, and alive!", myMessage: false)
        MessageCell(message: "I'm here, and alive!", myMessage: false)
    }
}

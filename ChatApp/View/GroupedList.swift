//
//  GroupedList.swift
//  ChatApp
//
//  Created by GradByte on 23.01.2024.
//

import Foundation
import SwiftUI

struct GroupedListHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "tray.full.fill")
            Text("All Messages")
        }
    }
}

struct GroupedListFooter: View {
    var body: some View {
        HStack {
            Image(systemName: "figure.socialdance")
            Text("gradbyte.codes")
        }
    }
}


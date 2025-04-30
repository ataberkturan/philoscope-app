//
//  HistoryListCell.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import SwiftUI

struct HistoryListCell: View {
    
    // MARK: - Properties
    let conversation: Conversation
    
    // MARK: - Body
    var body: some View {
        Text(conversation.title)
            .foregroundStyle(Color.labelPrimary)
            .font(.body)
            .fontWeight(.bold)
            .fontDesign(.rounded)
            .lineLimit(1)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 46)
            .background(Color.accentSecondary)
            .cornerRadius(12)
    }
}

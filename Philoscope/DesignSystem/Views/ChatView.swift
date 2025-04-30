//
//  ChatView.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import SwiftUI

struct ChatView: View {
    
    // MARK: - Properties
    var messages: [ChatMessage]
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(messages.sorted(by: { $0.createdAt < $1.createdAt }), id: \.id) { message in
                    MessageBubble(message: message)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ChatView(messages: [ChatMessage(bubbleStyle: .user, text: "Hello, World! sdfsdf sadfsadfasdfsadfsdafsdfsadfsdasdfsadfsadfasdfasdfdsaf")])
}

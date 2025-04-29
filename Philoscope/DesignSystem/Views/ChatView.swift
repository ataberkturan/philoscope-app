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
            VStack(alignment: .leading, spacing: 24) {
                ForEach(messages) { message in
                    MessageBubble(message: message)
                }
            }
            .padding(.vertical, 12)
        }
    }
}

#Preview {
    ChatView(messages: [ChatMessage(bubbleStyle: .user, text: "Hello, World! sdfsdf sadfsadfasdfsadfsdafsdfsadfsdasdfsadfsadfasdfasdfdsaf")])
}

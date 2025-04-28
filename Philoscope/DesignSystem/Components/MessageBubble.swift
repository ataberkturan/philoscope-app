//
//  MessageBubble.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import SwiftUI

struct MessageBubble: View {
    
    // MARK: - Properties
    let style: Style
    let messageText: String
    
    // MARK: - Enums
    enum Style {
        case system
        case response(image: Image)
        case user
    }
    
    // MARK: - Body
    var body: some View {
        switch style {
        case .system:
            systemStyleBubble
        case .response(let image):
            responseStyle(image: image)
        case .user:
            userStyleBubble
        }
    }
}

// MARK: - Helper Views
extension MessageBubble {
    
    var systemStyleBubble: some View {
        HStack(alignment: .bottom, spacing: 8) {
            // Icon
            Image(.senderIcon)
                .resizable()
                .scaledToFit()
                .frame(height: 32)
            // Text
            bubbleText(background: .accentSecondary)
                .frame(width: .screenWidth * 0.70)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func responseStyle(image: Image) -> some View {
        HStack(alignment: .bottom, spacing: 8) {
            // Icon
            Image(.senderIcon)
                .resizable()
                .scaledToFit()
                .frame(height: 32)
            // Response Image
            image
                .resizable()
                .scaledToFit()
                .frame(height: 256)
                .cornerRadius(12)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var userStyleBubble: some View {
        // Text
        bubbleText(background: .accent)
            .frame(width: .screenWidth * 0.70)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private func bubbleText(background: Color) -> some View {
        Text(messageText)
            .font(.body)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .padding(10)
            .foregroundStyle(.labelPrimary)
            .background(background)
            .cornerRadius(12)
    }
}


// MARK: - Preview
#Preview {
    MessageBubble(style: .user, messageText: "Speak, dear seeker… and I shall unveil what lies twenty years hence. Describe thy vision, and let the mirror conjure fate!")
}

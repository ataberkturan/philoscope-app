//
//  MessageBubble.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import SwiftUI

struct MessageBubble: View {
    
    // MARK: - Properties
    var message: ChatMessage
    
    // MARK: - Enums
    enum Style: Codable, Equatable {
        case system
        case response(imageURL: String)
        case user
        case loading
        case error
    }
    
    // MARK: - Body
    var body: some View {
        switch message.bubbleStyle {
        case .system:
            systemStyleBubble
        case .response(let imageURL):
            responseStyle(imageURL: imageURL)
        case .user:
            userStyleBubble
        case .loading:
            loadingStyleBubble
        case .error:
            errorStyleBubble
        }
    }
}

// MARK: - Helper Views
extension MessageBubble {
    
    var systemStyleBubble: some View {
        HStack(alignment: .bottom, spacing: 8) {
            // Icon
            senderIcon
            // Text
            bubbleText(message.text, background: .accentSecondary)
                .frame(width: .screenWidth * 0.70, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func responseStyle(imageURL: String) -> some View {
        HStack(alignment: .bottom, spacing: 8) {
            // Icon
            senderIcon
            
            // Response Image
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 256, height: 256)
                        .cornerRadius(12)
                case .failure(let error):
                    bubbleText(error.localizedDescription, background: .red)
                        .frame(width: .screenWidth * 0.70, alignment: .leading)
                case .empty:
                    ProgressView()
                        .frame(width: 256, height: 256)
                        .background(Color.accentSecondary)
                        .cornerRadius(12)
                @unknown default:
                    ProgressView()
                        .frame(width: 256, height: 256)
                        .background(Color.accentSecondary)
                        .cornerRadius(12)
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var userStyleBubble: some View {
        // Text
        bubbleText(message.text, background: .accent)
            .frame(width: .screenWidth * 0.70, alignment: .trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    var loadingStyleBubble: some View {
        HStack(alignment: .bottom, spacing: 8) {
            // Icon
            senderIcon
            // Text
            loadingText
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var errorStyleBubble: some View {
        bubbleText(message.text, background: .red)
            .frame(width: .screenWidth * 0.70, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var senderIcon: some View {
        Image(.senderIcon)
            .resizable()
            .scaledToFit()
            .frame(height: 32)
    }
    
    private var loadingText: some View {
        LoadingDotsText(prefix: message.text)
            .font(.body)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .padding(10)
            .foregroundStyle(.labelPrimary)
            .background(.accentSecondary)
            .cornerRadius(12)
            .frame(width: .screenWidth * 0.70, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func bubbleText(_ messageText: String, background: Color) -> some View {
        HStack {
            Text(messageText)
                .font(.body)
                .fontWeight(.medium)
                .fontDesign(.rounded)
        }
        .padding(10)
        .foregroundStyle(.labelPrimary)
        .background(background)
        .cornerRadius(12)
    }
}

// MARK: - Preview
#Preview {
    MessageBubble(message: .init(bubbleStyle: .loading, text: "Hello"))
}

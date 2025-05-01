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
    enum Style: Codable, Equatable, Identifiable {
        case system
        case response
        case user
        case loading
        case error
        var id: UUID { UUID() }
    }
    
    // MARK: - Body
    var body: some View {
        switch message.bubbleStyle {
        case .system:
            systemStyleBubble
        case .response:
            responseStyle
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
    
    var responseStyle: some View {
        HStack(alignment: .bottom, spacing: 8) {
            // Icon
            senderIcon
            
            // Response Image
            if let imageData = message.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 256, height: 256)
                    .cornerRadius(12)
                    .contextMenu {
                        saveImageButton(uiImage: uiImage)
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
        HStack(alignment: .bottom, spacing: 8) {
            // Icon
            senderIcon
            // Text
            bubbleText(message.text, background: .error)
                .frame(width: .screenWidth * 0.70, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func saveImageButton(uiImage: UIImage) -> some View {
        Button {
            UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
        } label: {
            Label(Constants.MessageBubble.saveImageLabel, systemImage: Symbol.saveImage.name)
        }
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

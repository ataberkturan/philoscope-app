//
//  ChatMessage.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class ChatMessage: Identifiable {
    var id = UUID()
    var bubbleStyle: MessageBubble.Style
    var text: String

    @Attribute
    var imageData: Data? = nil

    init(
        id: UUID = UUID(),
        bubbleStyle: MessageBubble.Style,
        text: String,
        imageData: Data? = nil
    ) {
        self.id = id
        self.bubbleStyle = bubbleStyle
        self.text = text
        self.imageData = imageData
    }
}

// MARK: - Dummy Data
extension ChatMessage {
    static var systemDefaultMessage: ChatMessage {
        ChatMessage(bubbleStyle: .system, text: "Speak, dear seeker… and I shall unveil what lies twenty years hence. Describe thy vision, and let the mirror conjure fate!")
    }
    
    /// Sample messages for preview and testing
    static var dummyMessages: [ChatMessage] {
        return [
            ChatMessage(bubbleStyle: .system, text: "Speak, dear seeker… and I shall unveil what lies twenty years hence. Describe thy vision, and let the mirror conjure fate!"),
            ChatMessage(bubbleStyle: .user, text: "Hello, show me the future Turkey "),
            ChatMessage(bubbleStyle: .response(imageURL: "https://picsum.photos/256/256"), text: "")
        ]
    }
}

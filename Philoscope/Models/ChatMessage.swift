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
    
    var createdAt: Date

    init(
        id: UUID = UUID(),
        bubbleStyle: MessageBubble.Style,
        text: String,
        imageData: Data? = nil,
        createdAt: Date = .now
    ) {
        self.id = id
        self.bubbleStyle = bubbleStyle
        self.text = text
        self.imageData = imageData
        self.createdAt = createdAt
    }
}

// MARK: - Dummy Data
extension ChatMessage {
    static var systemDefaultMessage: ChatMessage {
        ChatMessage(bubbleStyle: .system, text: Constants.MessageBubble.systemDefaultMessage)
    }
}

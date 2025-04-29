//
//  ConversationHistory.swift
//  Philoscope
//
//  Created by Ataberk Turan on 29/04/2025.
//

import Foundation
import SwiftData

@Model
class ConversationHistory: Identifiable {
    var id = UUID()
    var conversations: [Conversation]
    
    init(id: UUID = UUID(), conversations: [Conversation]) {
        self.id = id
        self.conversations = conversations
    }
}

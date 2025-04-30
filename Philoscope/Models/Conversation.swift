//
//  Conversation.swift
//  Philoscope
//
//  Created by Ataberk Turan on 29/04/2025.
//

import Foundation
import SwiftData

@Model
class Conversation: Identifiable {
    var id = UUID()
    var title: String
    var messages: [ChatMessage]
    
    init(id: UUID = UUID(), title: String, messages: [ChatMessage]) {
        self.id = id
        self.title = title
        self.messages = messages
    }
}

//
//  PhiloscopeApp.swift
//  Philoscope
//
//  Created by Ataberk Turan on 24/04/2025.
//

import SwiftUI
import SwiftData

@main
struct PhiloscopeApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(
            for: [
                ChatMessage.self,
                Conversation.self
            ]
        )
    }
}

//
//  HapticManager.swift
//  Philoscope
//
//  Created by Ataberk Turan on 30/04/2025.
//

import SwiftUI

struct HapticManager {
    
    // MARK: - Properties
    static let shared = HapticManager()
    
    // MARK: - Initializers
    private init() {
        // Prime haptic generators on app launch
        UINotificationFeedbackGenerator().prepare()
        UIImpactFeedbackGenerator(style: .medium).prepare()
    }
    
    // MARK: - Helper Methods
    func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

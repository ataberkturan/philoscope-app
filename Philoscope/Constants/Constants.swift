//
//  Constants.swift
//  Philoscope
//
//  Created by Ataberk Turan on 01/05/2025.
//

import Foundation

struct Constants {
    struct Secrets {
        static let openAIKey: String = "OPEN_AI_KEY_HERE"
        static let openAIBaseURL: URL = URL(string: "https://api.openai.com")!
        
        struct NavigationIDs {
            static let history: String = "history"
        }
        
        struct Prompts {
            static let refinePromptSystem: String = """
            You are a mystical sorcerer speaking through a future‑telling mirror. \
            Expand the user's short topic into a single, vivid image prompt that \
            describes the predicted future scene in rich detail. \
            Output ONLY valid JSON matching the provided schema.
            """
        }
    }
    
    struct HomeView {
        static let placeholder: String = NSLocalizedString("HomeView.PlaceholderText", comment: "")
        static let navigationTitle: String = NSLocalizedString("HomeView.NavigationTitle", comment: "")
    }
    
    struct HistoryView {
        static let emptyStateTitle: String = NSLocalizedString("HistoryView.EmptyTitle", comment: "")
        static let emptyStateDescription: String = NSLocalizedString("HistoryView.EmptyDescription", comment: "")
        static let navigationTitle: String = NSLocalizedString("HistoryView.NavigationTitle", comment: "")
        static let deleteButtonTitle: String = NSLocalizedString("HistoryView.DeleteButtonTitle", comment: "")
    }
    
    struct HomeViewModel {
        static let loadingMessage: String = NSLocalizedString("HomeViewModel.LoadingMessage", comment: "")
        static let preparingMessage: String = NSLocalizedString("HomeViewModel.PreparingMessage", comment: "")
        static let errorMessage: String = NSLocalizedString("HomeViewModel.ErrorMessage", comment: "")
    }

    struct MessageBubble {
        static let saveImageLabel: String = NSLocalizedString("MessageBubble.SaveImageLabel", comment: "")
        static let systemDefaultMessage: String = NSLocalizedString("MessageBubble.SystemDefaultMessage", comment: "")
    }
}

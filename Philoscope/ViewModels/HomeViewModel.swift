//
//  HomeViewModel.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import Foundation
import SwiftfulRouting
import UIKit
import SwiftData

@Observable
class HomeViewModel {
    
    // MARK: - Properties
    let router: AnyRouter
    var conversation: Conversation
    var messageText: String = ""
    @MainActor var phase: GenerationPhase = .idle
    @MainActor var isLoading: Bool = false

    private var generationTask: Task<Void, Never>?

    // MARK: - OpenAI Services
    private let promptService: PromptService
    private let imageService: ImageService
    
    // MARK: - Initializers
    init(router: AnyRouter) {
        self.router = router
        
        let conversation = Conversation(title: "", messages: [.systemDefaultMessage])
        self.conversation = conversation
        
        let client = OpenAIClient()
        self.promptService = PromptService(client: client)
        self.imageService  = ImageService(client: client)
    }
    
    // MARK: - Helper Methods
    @MainActor
    func sendMessage(modelContext: ModelContext) {
        guard !messageText.isEmpty else { return }
        HapticManager.shared.impact(.medium)

        conversation.title = messageText
        
        let userMessage = ChatMessage(bubbleStyle: .user, text: messageText)
        conversation.messages.append(userMessage)

        let prompt = messageText
        messageText = ""

        generationTask?.cancel()
        generationTask = Task {
            await generateImage(for: prompt, modelContext: modelContext)
        }
    }

    // MARK: - Image Pipeline
    @MainActor
    private func generateImage(for prompt: String, modelContext: ModelContext) async {
        phase = .refining
        conversation.messages.append(
            ChatMessage(
                bubbleStyle: .loading,
                text: "🔮 Gaze deep into the swirling mists... I am weaving the strands of fate to reveal your future. Patience, for the vision is taking shape"
            )
        )
        
        isLoading = true
        defer { isLoading = false }

        do {
            let refinedPrompt = try await promptService.refinePrompt(prompt)
            phase = .generating
            
            if let lastLoadingIndex = conversation.messages.lastIndex(where: { $0.bubbleStyle == .loading }) {
                conversation.messages[lastLoadingIndex].text =
                    "🔮 The swirling shapes converge within the mirror, preparing the vision"
            }
            
            let result = try await imageService.generateImage(from: refinedPrompt)
            let data = result.data

            conversation.messages.removeLast()
            let responseMsg = ChatMessage(
                bubbleStyle: .response,
                text: "",
                imageData: data
            )
            conversation.messages.append(responseMsg)
            phase = .finished
            
            HapticManager.shared.notification(.success)
            
            modelContext.insert(conversation)
        } catch {
            guard let task = generationTask else { return }
            if task.isCancelled { return }
            
            HapticManager.shared.notification(.error)
            
            conversation.messages.removeLast()
            conversation.messages.append(
                ChatMessage(
                    bubbleStyle: .error,
                    text: "An error has darkened the mirror"
                )
            )
            phase = .error(error.localizedDescription)
        }
    }

    @MainActor
    func cancelGeneration() {
        generationTask?.cancel()
        generationTask = nil
    }
    
    @MainActor
    func navigateToHistory() {
        router.showScreen(.sheet, id: "history") { router in
            HistoryView(viewModel: self)
        }
    }
    
    @MainActor
    func setMessagesToSelected(with selectedConversation: Conversation) {
        cancelGeneration()
        self.conversation = selectedConversation
        router.dismissScreen(id: "history")
        HapticManager.shared.impact(.medium)
    }
    
    @MainActor
    func newConversation() {
        guard !conversation.title.isEmpty else { return }
        cancelGeneration()
        HapticManager.shared.impact(.medium)
        let conversation = Conversation(title: "", messages: [.systemDefaultMessage])
        self.conversation = conversation
    }
}

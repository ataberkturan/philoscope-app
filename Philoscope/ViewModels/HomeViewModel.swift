//
//  HomeViewModel.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import Foundation
import SwiftfulRouting
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
        addUserMessage(messageText)

        let prompt = messageText
        messageText = ""

        generationTask?.cancel()
        generationTask = Task {
            await generateImage(for: prompt, modelContext: modelContext)
        }
    }

    @MainActor
    func cancelGeneration() {
        generationTask?.cancel()
        generationTask = nil
    }
    
    @MainActor
    func navigateToHistory() {
        router.showScreen(.sheet, id: Constants.Secrets.NavigationIDs.history) { router in
            HistoryView(viewModel: self)
        }
    }
    
    @MainActor
    func setMessagesToSelected(with selectedConversation: Conversation) {
        cancelGeneration()
        self.conversation = selectedConversation
        router.dismissScreen(id: Constants.Secrets.NavigationIDs.history)
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

// MARK: - Message Helpers
extension HomeViewModel {
    @MainActor
    fileprivate func addUserMessage(_ text: String) {
        conversation.messages.append(ChatMessage(bubbleStyle: .user, text: text))
    }

    @MainActor
    fileprivate func addLoadingMessage() {
        conversation.messages.append(ChatMessage(bubbleStyle: .loading,
                                                 text: Constants.HomeViewModel.loadingMessage))
    }

    @MainActor
    fileprivate func updateLoadingMessage() {
        if let index = conversation.messages.lastIndex(where: { $0.bubbleStyle == .loading }) {
            conversation.messages[index].text = Constants.HomeViewModel.preparingMessage
        }
    }

    @MainActor
    fileprivate func addResponseImage(_ data: Data) {
        conversation.messages.append(ChatMessage(bubbleStyle: .response,
                                                 text: "",
                                                 imageData: data))
    }

    @MainActor
    fileprivate func addErrorMessage() {
        conversation.messages.append(ChatMessage(bubbleStyle: .error,
                                                 text: Constants.HomeViewModel.errorMessage))
    }
}

// MARK: - Networking
extension HomeViewModel {
    fileprivate func refine(_ prompt: String) async throws -> String {
        try await promptService.refinePrompt(prompt)
    }

    fileprivate func fetchImageData(for refinedPrompt: String) async throws -> Data {
        let result = try await imageService.generateImage(from: refinedPrompt)
        return result.data
    }
}

// MARK: - Image Pipeline
extension HomeViewModel {
    @MainActor
    fileprivate func generateImage(for prompt: String, modelContext: ModelContext) async {
        phase = .refining
        addLoadingMessage()
        isLoading = true
        defer { isLoading = false }

        do {
            let refined = try await refine(prompt)
            guard !Task.isCancelled else { throw CancellationError() }

            phase = .generating
            updateLoadingMessage()

            let imageData = try await fetchImageData(for: refined)
            guard !Task.isCancelled else { throw CancellationError() }

            // Remove loading message then append image
            conversation.messages.removeLast()
            addResponseImage(imageData)
            phase = .finished
            HapticManager.shared.notification(.success)
            modelContext.insert(conversation)

        } catch is CancellationError {
            // Ignoring error if the task was cancelled
            return
        } catch {
            conversation.messages.removeAll(where: { $0.bubbleStyle == .loading })
            addErrorMessage()
            phase = .error(error.localizedDescription)
            HapticManager.shared.notification(.error)
        }
    }
}

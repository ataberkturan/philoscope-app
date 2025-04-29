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
    var messages: [ChatMessage] = [.systemDefaultMessage]
    var messageText: String = ""
    
    // MARK: - OpenAI Services
    private let promptService: PromptService
    private let imageService: ImageService

    // MARK: - UI State
    @MainActor var isLoading: Bool = false
    @MainActor var errorMessage: String?
    @MainActor var phase: GenerationPhase = .idle
    
    // MARK: - Initializers
    init(router: AnyRouter) {
        self.router = router

        let client = OpenAIClient(apiKey: "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")
        self.promptService = PromptService(client: client)
        self.imageService  = ImageService(client: client)
    }
    
    // MARK: - Helper Methods
    
    @MainActor func sendMessage() {
        guard !messageText.isEmpty else { return }

        let userMessage = ChatMessage(bubbleStyle: .user, text: messageText)
        messages.append(userMessage)

        let prompt = messageText
        messageText = ""
        
        Task { await generateImage(for: prompt) }
    }

    // MARK: - Image Pipeline
    @MainActor
    private func generateImage(for prompt: String) async {
        phase = .refining
        messages.append(
            ChatMessage(
                bubbleStyle: .loading,
                text: "🔮 Gaze deep into the swirling mists... I am weaving the strands of fate to reveal your future. Patience, for the vision is taking shape"
            )
        )
        
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let refinedPrompt = try await promptService.refinePrompt(prompt)
            phase = .generating
            
            if let lastLoadingIndex = messages.lastIndex(where: { $0.bubbleStyle == .loading }) {
                messages[lastLoadingIndex].text =
                    "🔮 The swirling shapes converge within the mirror, preparing the vision"
            }
            
            let result = try await imageService.generateImage(from: refinedPrompt)

            guard let pngData = result.image.pngData() else {
                throw URLError(.cannotCreateFile)
            }
            let filename = UUID().uuidString + ".png"
            let fileURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(filename)
            try pngData.write(to: fileURL, options: .atomic)

            messages.removeLast()
            // Load raw image bytes
            let imageBytes = try Data(contentsOf: fileURL)
            // Create and persist the ChatMessage with image data
            let responseMsg = ChatMessage(
                bubbleStyle: .response(imageURL: fileURL.absoluteString),
                text: "",
                imageData: imageBytes
            )
            messages.append(responseMsg)
            phase = .finished
        } catch {
            messages.removeLast()
            messages.append(
                ChatMessage(
                    bubbleStyle: .system,
                    text: "An error has darkened the mirror: \(error.localizedDescription)"
                )
            )
            phase = .error(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    
    @MainActor
    func navigateToHistory() {
        router.showScreen(.sheet) { router in
            HistoryView()
        }
    }
}

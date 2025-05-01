//
//  PromptService.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import Foundation

struct PromptService {
    
    // MARK: - Properties
    private let client: OpenAIClient
    
    // MARK: - Initializers
    init(client: OpenAIClient) {
        self.client = client
    }
    
    // MARK: – Helper Methods
    func refinePrompt(_ shortPrompt: String) async throws -> String {
        let systemMessage = ChatMessageDTO(
            role: "system",
            content: Constants.Secrets.Prompts.refinePromptSystem
        )
        
        let userMessage = ChatMessageDTO(
            role: "user",
            content: shortPrompt
        )
        
        let req = ChatCompletionRequest(
            model: "gpt-4o-mini",
            messages: [systemMessage, userMessage],
            response_format: ResponseFormat(
                type: "json_schema",
                json_schema: Schema(
                    name: "prompt_refinement",
                    strict: true,
                    schema: SchemaDef(
                        type: "object",
                        properties: ["detailed_prompt": [
                            "type": "string",
                            "description": "Expanded and vivid image prompt"
                        ]],
                        required: ["detailed_prompt"],
                        additionalProperties: false
                    )
                )
            )
        )
        let res: ChatCompletionResponse = try await client.post(.chat, body: req)
        guard
            let raw = res.choices.first?.message.content,
            let data = raw.data(using: .utf8)
        else { throw URLError(.cannotParseResponse) }
        
        let parsed = try JSONDecoder().decode(PromptRefinement.self, from: data)
        return parsed.detailed_prompt
    }
}

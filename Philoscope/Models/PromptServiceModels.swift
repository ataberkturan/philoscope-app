//
//  PromptServiceModels.swift
//  Philoscope
//
//  Created by Ataberk Turan on 29/04/2025.
//

import Foundation

struct ChatCompletionRequest: Encodable {
    let model: String
    let messages: [ChatMessageDTO]
    let response_format: ResponseFormat
}

struct ChatMessageDTO: Encodable {
    let role: String
    let content: String
}

struct ResponseFormat: Encodable {
    let type: String
    let json_schema: Schema
}

struct Schema: Encodable {
    let name: String
    let strict: Bool
    let schema: SchemaDef
}

struct SchemaDef: Encodable {
    let type: String
    let properties: [String: [String: String]]
    let required: [String]
    let additionalProperties: Bool
}

struct ChatCompletionResponse: Decodable {
    struct Choice: Decodable {
        struct Message: Decodable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}

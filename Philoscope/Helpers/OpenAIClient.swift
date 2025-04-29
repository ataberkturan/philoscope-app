//
//  OpenAIClient.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import Foundation

struct OpenAIClient {
    
    // MARK: - Properties
    private let key: String
    private let session = URLSession.shared
    private let base = URL(string: "https://api.openai.com")!
    
    // MARK: - Enums
    enum Endpoint: String {
        case chat = "/v1/chat/completions"
        case images = "/v1/images/generations"
    }
    
    // MARK: - Initializers
    init(apiKey: String) {
        self.key = apiKey
    }
    
    // MARK: - Helper Methods

    func post<Req: Encodable, Res: Decodable>(
        _ ep: Endpoint, body: Req
    ) async throws -> Res {
        // Encode body
        let payload = try JSONEncoder().encode(body)

        // Build request
        var request = URLRequest(url: base.appendingPathComponent(ep.rawValue))
        request.httpMethod = "POST"
        request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload

        // Execute
        let (data, response) = try await session.data(for: request)
        let status = (response as? HTTPURLResponse)?.statusCode ?? -1

        guard status == 200 else {
            let body = String(decoding: data, as: UTF8.self)
            throw OpenAIClientError.badStatus(status, body)
        }

        do {
            let decoded = try JSONDecoder().decode(Res.self, from: data)
            return decoded
        } catch {
            throw OpenAIClientError.decoding(error)
        }
    }
}

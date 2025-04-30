//
//  ImageService.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import Foundation
import UIKit

struct ImageService {
    
    // MARK: - Properties
    private let client: OpenAIClient
    
    // MARK: - Initializers
    init(client: OpenAIClient) { self.client = client }
    
    // MARK: - Helper Methods
    func generateImage(from prompt: String) async throws -> ImageResult {
        let req = ImageGenerationRequest(
            model: "dall-e-3",
            prompt: prompt,
            n: 1,
            size: "1024x1024",
            response_format: "b64_json"
        )
        let res: ImageGenerationResponse = try await client.post(.images, body: req)
        
        guard
            let b64 = res.data.first?.b64_json,
            let imgData = Data(base64Encoded: b64)
        else { throw URLError(.cannotDecodeContentData) }
        
        return ImageResult(prompt: prompt, data: imgData)
    }
}

//
//  ImageService.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import Foundation
import UIKit

/// Sends the refined prompt to **gpt-image-1** and decodes `UIImage`.
struct ImageService {
    private let client: OpenAIClient
    init(client: OpenAIClient) { self.client = client }

    func generateImage(from prompt: String) async throws -> ImageResult {
        let req = ImageGenerationRequest(
            model: "gpt-image-1",
            prompt: prompt,
            n: 1,
            size: "1024x1024"
        )
        let res: ImageGenerationResponse = try await client.post(.images, body: req)

        guard
            let b64 = res.data.first?.b64_json,
            let imgData = Data(base64Encoded: b64),
            let uiImg = UIImage(data: imgData)
        else { throw URLError(.cannotDecodeContentData) }

        return .init(prompt: prompt, image: uiImg)
    }
}

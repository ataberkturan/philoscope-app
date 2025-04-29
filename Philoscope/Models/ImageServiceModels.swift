//
//  ImageServiceModels.swift
//  Philoscope
//
//  Created by Ataberk Turan on 29/04/2025.
//

import Foundation

struct ImageGenerationRequest: Encodable {
    let model: String
    let prompt: String
    let n: Int
    let size: String
}

struct ImageDatum: Decodable {
    let b64_json: String
}

struct ImageGenerationResponse: Decodable {
    let data: [ImageDatum]
}

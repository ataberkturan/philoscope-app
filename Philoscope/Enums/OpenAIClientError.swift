//
//  OpenAIClientError.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import Foundation

enum OpenAIClientError: Error {
    case badStatus(Int, String)
    case decoding(Error)
}

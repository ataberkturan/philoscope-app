//
//  GenerationPhase.swift
//  Philoscope
//
//  Created by Ataberk Turan on 29/04/2025.
//

import Foundation

enum GenerationPhase: Equatable {
    case idle
    case refining
    case generating
    case finished
    case error(String)
}

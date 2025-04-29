//
//  ImageResult.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import UIKit

/// Convenience wrapper for the generated UIImage plus the prompt we fed to gpt-image-1.
struct ImageResult {
    let prompt: String        // what went to gpt-image-1
    let image: UIImage        // decoded PNG/JPEG/WebP
}

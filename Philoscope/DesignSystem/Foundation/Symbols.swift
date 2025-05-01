//
//  Symbols.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//


import Foundation
import SwiftUI

struct Symbol {
    let name: String
    var image: Image { Image(systemName: name) }
}

extension Symbol {
    static let magic = Symbol(name: "wand.and.sparkles")
    static let history = Symbol(name: "clock.arrow.trianglehead.counterclockwise.rotate.90")
    static let plus = Symbol(name: "plus")
    static let xmark = Symbol(name: "xmark")
    static let saveImage = Symbol(name: "arrow.down.circle.fill")
    static let trash = Symbol(name: "trash.fill")
}

//
//  LoadingDotsText.swift
//  Philoscope
//
//  Created by Ataberk Turan on 29/04/2025.
//

import SwiftUI

struct LoadingDotsText: View {
    
    // MARK: - Properties
    let prefix: String
    @State private var dotCount = 0
    private let maxDots = 3
    private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    // MARK: - Body
    var body: some View {
        let dots = String(repeating: ".", count: dotCount)
        Text(prefix + dots)
            .onReceive(timer) { _ in
                // advance and wrap
                dotCount = (dotCount + 1) % (maxDots + 1)
            }
    }
}

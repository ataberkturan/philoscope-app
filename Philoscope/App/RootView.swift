//
//  RootView.swift
//  Philoscope
//
//  Created by Ataberk Turan on 24/04/2025.
//

import SwiftUI
import SwiftfulRouting

struct RootView: View {
    var body: some View {
        RouterView { router in
            HomeView(viewModel: .init(router: router))
        }
    }
}

#Preview {
    RootView()
}

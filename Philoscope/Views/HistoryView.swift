//
//  HistoryView.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import SwiftUI
import SwiftData
import SwiftfulRouting

struct HistoryView: View {
    
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(0..<3) { index in
                    HistoryListCell(title: "Hello world")
                }
            }
            .padding(.horizontal, 16)
        }
        .background(Color.background)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Navigation Title
            navigationTitle
            // Navigation Trailing Button
            dismissButton
        }
    }
}

// MARK: - Helper Views
extension HistoryView {
    var dismissButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                Image.xmarkIcon
                    .resizable()
                    .scaledToFit()
                    .frame(height: 10)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.accent.opacity(0.6))
            }
            .background(Color.accentSecondary.opacity(0.3))
            .buttonStyle(.bordered)
            .frame(height: 24)
            .clipShape(Circle())
        }
    }
    
    var navigationTitle: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("History")
                .foregroundStyle(.accent)
                .font(.headline)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
        }
    }
}

// MARK: - Previews
#Preview {
    RouterView { router in
        HistoryView()
    }
}

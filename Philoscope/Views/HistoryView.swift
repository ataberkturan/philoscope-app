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
    @Query private var conversations: [Conversation]
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: HomeViewModel
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                if conversations.isEmpty {
                    contentUnavailableView
                } else {
                    content
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
    var content: some View {
        ForEach(conversations) { conversation in
            HistoryListCell(conversation: conversation)
                .onTapGesture {
                    viewModel.setMessagesToSelected(with: conversation)
                }
                .contextMenu {
                    Button("Delete", systemImage: "trash.fill", role: .destructive) {
                        modelContext.delete(conversation)
                    }
                }
        }
    }
    
    var contentUnavailableView: some View {
        ContentUnavailableView("No Conversations",
            systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90",
            description:
                Text("Start a new conversation to see it appear here.")
            .foregroundStyle(.accent.opacity(0.8))
        )
        .foregroundStyle(.accent)
        .fontDesign(.rounded)
    }
    
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
        HistoryView(viewModel: .init(router: router))
    }
}

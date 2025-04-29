//
//  HomeView.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import SwiftUI
import SwiftfulRouting
import SwiftData

struct HomeView: View {
    
    // MARK: - Properties
    @State var viewModel: HomeViewModel
    @State var messageText: String = ""
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: .zero) {
            ChatView(messages: viewModel.messages)
                .animation(.easeInOut, value: viewModel.messages)
            PromptField(
                text: $viewModel.messageText,
                placeholder: "Type what you wanna see...",
                sendAction: {
                    viewModel.sendMessage()
            })
            .padding(.bottom, 12)
        }
        .padding(.horizontal, 16)
        .background(Color.background)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Navigation Leading Button
            openhistoryButton
            // Navigation Title
            navigationTitle
            // Navigation Trailing Button
            newChatButton
        }
    }
}

// MARK: - Helper Views
extension HomeView {
    
    var openhistoryButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                viewModel.navigateToHistory()
            } label: {
                Image.historyIcon
                    .foregroundStyle(.accent)
                    .font(.title3)
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
            }
        }
    }
    
    var newChatButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                // New Chat Action
            } label: {
                Image.plusIcon
                    .foregroundStyle(.accent)
                    .font(.title3)
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
            }
        }
    }
    
    var navigationTitle: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("Philoscope")
                .foregroundStyle(.accent)
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
        }
    }
}

// MARK: - Previews
#Preview {
    RouterView { router in
        HomeView(viewModel: .init(router: router))
    }
}

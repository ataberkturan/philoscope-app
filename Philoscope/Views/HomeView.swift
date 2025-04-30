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
    @Environment(\.modelContext) private var modelContext
    @FocusState private var isFocused: Bool
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: .zero) {
            ChatView(messages: viewModel.conversation.messages)
                .padding(.horizontal, -16)
                .animation(.easeInOut, value: viewModel.conversation.messages)
            
            PromptField(
                text: $viewModel.messageText,
                placeholder: "Type what you wanna see...",
                isSendButtonDisabled: viewModel.isLoading,
                sendAction: {
                    viewModel.sendMessage(modelContext: self.modelContext)
                })
            .padding(.bottom, 12)
            .focused($isFocused)
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
            newConversationButton
        }
        .onTapGesture {
            isFocused = false
        }
        .onDisappear {
            viewModel.cancelGeneration()
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
    
    var newConversationButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.newConversation()
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

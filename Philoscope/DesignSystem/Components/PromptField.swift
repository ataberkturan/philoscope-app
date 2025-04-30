//
//  PromptField.swift
//  Philoscope
//
//  Created by Ataberk Turan on 28/04/2025.
//

import SwiftUI

struct PromptField: View {
    
    // MARK: - Properties
    @Binding var text: String
    var placeholder: String
    var isSendButtonDisabled: Bool
    var sendAction: () -> Void
    
    // MARK: - Initializers
    init(text: Binding<String>, placeholder: String, isSendButtonDisabled: Bool = false, sendAction: @escaping () -> Void) {
        self._text = text
        self.placeholder = placeholder
        self.isSendButtonDisabled = isSendButtonDisabled
        self.sendAction = sendAction
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 4) {
            textField
            sendMessageButton
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(Color(.textfieldBackground))
        .cornerRadius(999)
        .padding(.vertical, 8)
        .background(Color.background)
        .onSubmit {
            sendAction()
        }
    }
}

// MARK: - Helper Views
extension PromptField {
    var textField: some View {
        TextField(
            "",
            text: $text,
            prompt: placeholderText
        )
        .foregroundStyle(.labelSecondary)
        .font(.body)
        .fontWeight(.medium)
        .fontDesign(.rounded)
        .padding(.leading, 8)
    }
    
    var placeholderText: Text {
        Text(placeholder)
            .foregroundStyle(.labelSecondary)
            .font(.body)
            .fontWeight(.medium)
            .fontDesign(.rounded)
    }
    
    var sendMessageButton: some View {
        Button {
            sendAction()
        } label: {
            Image.magicIcon
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .background(Color.accent)
                .clipShape(Circle())
                .opacity(isSendButtonDisabled ? 0.3 : 1.0)
        }
        .disabled(isSendButtonDisabled)
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var text: String = ""
    PromptField(text: $text, placeholder: "Type something...", sendAction: {})
}

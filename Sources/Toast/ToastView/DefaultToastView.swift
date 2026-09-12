//
//  DefaultToastView.swift
//  climbto350
//
//  Created by Steve Nimcheski on 9/6/25.
//

import SwiftUI

public struct DefaultToastView<T: ToastViewModel>: View {
    @State private var viewModel: T
    
    public init(viewModel: T = DefaultToastViewModel()) {
        _viewModel = State(initialValue: viewModel)
    }
    
    public var body: some View {
        if let toast = viewModel.toast {
            HStack {
                toastText(toast)
                Spacer()
                trailingButton(toast)
            }
            .font(.caption)
            .foregroundStyle(.background)
            .background(.primary)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding()
            .transition(.move(edge: .bottom))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

// MARK: - Private Views

private extension DefaultToastView {
    func toastText(_ toast: Toast) -> some View {
        Text(toast.type.message)
            .padding([.vertical, .leading])
    }
    
    @ViewBuilder
    func trailingButton(_ toast: Toast) -> some View {
        if let action = toast.type.action {
            actionButton(action)
        } else {
            closeButton
        }
    }
    
    func actionButton(_ action: ToastAction) -> some View {
        Button(action.title) {
            viewModel.dismissToast()
            action.handler()
        }
        .padding()
    }
    
    var closeButton: some View {
        Button("Close pop-up message", systemImage: "xmark", action: viewModel.dismissToast)
            .padding()
            .labelStyle(.iconOnly)
    }
}

// MARK: - Previews

#if DEBUG
#Preview {
    DefaultToastView(viewModel: PreviewToastViewModel(type: .general))
}
#endif

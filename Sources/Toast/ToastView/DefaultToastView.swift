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
                closeButton
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
    
    var closeButton: some View {
        Button {
            viewModel.dismissToast()
        } label: {
            Label("Close pop-up message", systemImage: "xmark")
                .labelStyle(.iconOnly)
                .padding()
                .contentShape(.rect)
        }
    }
}

// MARK: - Previews

#if DEBUG
#Preview {
    DefaultToastView(viewModel: PreviewToastViewModel())
}
#endif

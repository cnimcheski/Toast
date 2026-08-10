//
//  PreviewToastViewModel.swift
//  climbto350
//
//  Created by Steve Nimcheski on 1/5/26.
//

import SwiftUI

@MainActor
@Observable
final class PreviewToastViewModel: ToastViewModel {
    private(set) var toast: Toast?
    
    init(_ toast: Toast = .init(type: PreviewToastType.unknown)) {
        self.toast = toast
        startInfiniteToastLoop(using: toast)
    }
    
    func dismissToast() {
        guard let toast = toast else { return }
        withAnimation(.snappy) {
            self.toast = nil
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.snappy) {
                self.setupToast(toast)
            }
        }
    }
    
    func setupToast(_ toast: Toast) {
        withAnimation(.snappy) {
            self.toast = toast
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration) {
            guard self.toast == toast else { return }
            self.dismissToast()
        }
    }
}

// MARK: - Private Methods

private extension PreviewToastViewModel {
    func startInfiniteToastLoop(using toast: Toast) {
        Task {
            try? await Task.sleep(for: .seconds(1))
            setupToast(toast)
        }
    }
}

// MARK: - PreviewToastType

enum PreviewToastType: ToastType {
    case unknown
    
    var message: LocalizedStringKey {
        switch self {
        case .unknown:
            "Unknown Error."
        }
    }
    
    var defaultDuration: Double {
        switch self {
        case .unknown:
            5
        }
    }
}

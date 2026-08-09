//
//  DefaultToastViewModel.swift
//  climbto350
//
//  Created by Steve Nimcheski on 1/5/26.
//

import Combine
import SwiftUI

@MainActor
@Observable
public final class DefaultToastViewModel: ToastViewModel {
    public private(set) var toast: Toast?
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        setupPublishers()
    }
    
    public func setupToast(_ toast: Toast) {
        withAnimation(.snappy) {
            self.toast = toast
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration) {
            guard self.toast == toast else { return }
            self.dismissToast()
        }
    }
    
    public func dismissToast() {
        withAnimation(.snappy) {
            toast = nil
        }
    }
}

// MARK: - Setup publishers

private extension DefaultToastViewModel {
    func setupPublishers() {
        ToastManager.shared.toastPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] toast in
                self?.setupToast(toast)
            }
            .store(in: &cancellables)
    }
}

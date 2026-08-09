//
//  ToastCoordinatorViewModel.swift
//  climbto350
//
//  Created by Steve Nimcheski on 9/6/25.
//

import SwiftUI
import UIKit

@MainActor
@Observable
public final class ToastCoordinatorViewModel<ToastView: View> {
    private var overlayWindow: UIWindow?
    private let toastView: ToastView
    
    public init(@ViewBuilder toastView: () -> ToastView) {
        self.toastView = toastView()
    }
    
    func onAppear() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            overlayWindow == nil else { return }
        let window = PassthroughWindow(windowScene: windowScene)
        window.backgroundColor = .clear
        let rootController = UIHostingController(rootView: toastView)
        rootController.view.frame = windowScene.keyWindow?.frame ?? .zero
        rootController.view.backgroundColor = .clear
        window.rootViewController = rootController
        window.isHidden = false
        window.isUserInteractionEnabled = true
        overlayWindow = window
    }
}

// MARK: - PassthroughWindow Helper

fileprivate class PassthroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event),
              let rootView = rootViewController?.view else { return nil }
        /// Interaction needs to be handled differently based on iOS version
        /// Monitor and ensure proper behavior for future iOS versions as well
        if #available(iOS 26, *) {
            guard rootView.layer.hitTest(point)?.name == nil else { return nil }
            return rootView
        } else if #available(iOS 18, *) {
            for subview in rootView.subviews.reversed() {
                let pointInSubview = subview.convert(point, from: rootView)
                if subview.hitTest(pointInSubview, with: event) == subview {
                    return hitView
                }
            }
            return nil
        } else {
            return hitView == rootView ? nil : hitView
        }
    }
}

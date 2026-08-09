//
//  ToastCoordinator.swift
//  climbto350
//
//  Created by Steve Nimcheski on 9/6/25.
//

import SwiftUI

public struct ToastCoordinator<Content: View, ToastView: View>: View {
    @State private var viewModel: ToastCoordinatorViewModel<ToastView>
    private let content: Content
    
    public init(
        @ViewBuilder toastView: @escaping () -> ToastView,
        @ViewBuilder content: () -> Content
    ) {
        _viewModel = State(initialValue: .init(toastView: toastView))
        self.content = content()
    }
    
    public var body: some View {
        content
            .onAppear(perform: viewModel.onAppear)
    }
}

//
//  ToastManager.swift
//  climbto350
//
//  Created by Steve Nimcheski on 7/11/25.
//

import Combine

@MainActor
public final class ToastManager {
    private let toastSubject = PassthroughSubject<Toast, Never>()
    
    public var toastPublisher: AnyPublisher<Toast, Never> {
        toastSubject.eraseToAnyPublisher()
    }
    
    public static let shared = ToastManager()
    
    private init() {}
    
    public func show(_ type: any ToastType, customDuration: Double? = nil) {
        self.toastSubject.send(
            .init(
                type: type,
                customDuration: customDuration
            )
        )
    }
}

//
//  Toast.swift
//  climbto350
//
//  Created by Steve Nimcheski on 7/15/25.
//

import SwiftUI

public protocol ToastType: Equatable {
    var message: LocalizedStringKey { get }
    var defaultDuration: Double { get }
    var action: ToastAction? { get }
}

/// Defines an action that can be displayed as a trailing button on a toast.
public struct ToastAction {
    let title: LocalizedStringKey
    let handler: () -> Void
}

public struct Toast: Equatable {
    let id = UUID()
    let type: any ToastType
    let duration: Double
    
    public init(type: any ToastType, customDuration: Double? = nil) {
        self.type = type
        self.duration = customDuration ?? type.defaultDuration
    }
    
    public static func == (lhs: Toast, rhs: Toast) -> Bool {
        lhs.id == rhs.id
    }
}

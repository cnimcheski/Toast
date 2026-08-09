//
//  Toast.swift
//  climbto350
//
//  Created by Steve Nimcheski on 7/15/25.
//

import Foundation

public protocol ToastType: Equatable {
    var message: String { get }
    var defaultDuration: Double { get }
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

//
//  ToastViewModel.swift
//  climbto350
//
//  Created by Steve Nimcheski on 7/15/25.
//

import Observation

@MainActor
public protocol ToastViewModel: Observable {
    var toast: Toast? { get }
    func dismissToast()
    func setupToast(_ toast: Toast)
}

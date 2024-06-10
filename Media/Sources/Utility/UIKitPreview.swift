//
//  UIKitPreview.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import SwiftUI

struct UIKitPreview: UIViewControllerRepresentable {
    private let viewController: UIViewController
    
    init(_ viewController: () -> UIViewController) {
        self.viewController = viewController()
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        viewController
    }
    
    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
    }
}

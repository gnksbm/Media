//
//  UIKitPreview.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import SwiftUI

#if DEBUG
extension UIViewController {
    var preview: some View {
        UIViewControllerPreview {
            self
        }
    }
}

extension UIView {
    var preview: some View {
        UIViewPreview {
            self
        }
    }
}

struct UIViewControllerPreview: UIViewControllerRepresentable {
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

struct UIViewPreview: UIViewRepresentable {
    private let view: UIView
    
    init(_ view: () -> UIView) {
        self.view = view()
    }
    
    func makeUIView(context: Context) -> some UIView {
        view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
#endif

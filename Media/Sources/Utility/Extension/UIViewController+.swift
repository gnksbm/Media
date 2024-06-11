//
//  UIViewController+.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

extension UIViewController {
    class func defaultUISwizzle() {
        guard let viewDidLoad = class_getInstanceMethod(
            Self.self,
            #selector(Self.viewDidLoad)
        ),
        let configureDefaultUI = class_getInstanceMethod(
            Self.self,
            #selector(Self.configureDefaultUI)
        )
        else { return }
        method_exchangeImplementations(viewDidLoad, configureDefaultUI)
    }
    
    @objc dynamic func configureDefaultUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = ""
    }
}

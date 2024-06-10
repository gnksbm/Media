//
//  UIViewController+.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

extension UIViewController {
    class func backButtonTitleSwizzle() {
        guard let viewDidLoad = class_getInstanceMethod(
            Self.self,
            #selector(Self.viewDidLoad)
        ),
        let removeBackButtonTitle = class_getInstanceMethod(
            Self.self,
            #selector(Self.removeBackButtonTitle)
        )
        else { return }
        method_exchangeImplementations(viewDidLoad, removeBackButtonTitle)
    }
    
    @objc dynamic func removeBackButtonTitle() {
        navigationController?.navigationBar.topItem?.title = ""
    }
}

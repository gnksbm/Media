//
//  UIViewController+.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

extension UIViewController {
    enum OverlayHelper {
        static var isToastShowing = false
        static var progressView: UIProgressView?
    }
    
    func showProgressView() {
        guard OverlayHelper.progressView == nil else { return }
        let progressView = UIProgressView().build { builder in
            builder.trackTintColor(.separator)
                .progressTintColor(.red)
        }
        
        OverlayHelper.progressView = progressView
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            progressView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            progressView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            progressView.heightAnchor.constraint(
                equalToConstant: 5
            ),
        ])
        
        view.layoutIfNeeded()
    }
    
    func updateProgress(progress: Double) {
        OverlayHelper.progressView?.progress = Float(progress)
        view.layoutIfNeeded()
    }
    
    func appendProgress(progress: Double) {
        OverlayHelper.progressView?.progress =
        (OverlayHelper.progressView?.progress ?? 0) + Float(progress)
        view.layoutIfNeeded()
    }
    
    func hideProgressView() {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [.curveEaseIn],
            animations: {
                OverlayHelper.progressView?.progress = 1
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                OverlayHelper.progressView?.removeFromSuperview()
                OverlayHelper.progressView = nil
            }
        )
    }
    
    func showToast(message: String, duration: Double = 2) {
        guard !OverlayHelper.isToastShowing else { return }
        OverlayHelper.isToastShowing = true
        
        let toastView = ToastView().build { builder in
            builder.action { $0.updateMessage(message) }
        }
        
        view.addSubview(toastView)
        toastView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        
        let toastTopConstraint =
        toastView.bottomAnchor.constraint(equalTo: safeArea.topAnchor)
        
        NSLayoutConstraint.activate([
            toastView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            toastTopConstraint
        ])
        view.layoutIfNeeded()
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                toastTopConstraint.constant = toastView.bounds.height + 10
                toastView.alpha = 1
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.3,
                    delay: duration,
                    options: [.curveEaseIn],
                    animations: {
                        toastTopConstraint.constant = 0
                        toastView.alpha = 0
                        self.view.layoutIfNeeded()
                    },
                    completion: { _ in
                        toastView.removeFromSuperview()
                        OverlayHelper.isToastShowing = false
                    }
                )
            }
        )
    }
}

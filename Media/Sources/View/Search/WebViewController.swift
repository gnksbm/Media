//
//  WebViewController.swift
//  Media
//
//  Created by gnksbm on 7/1/24.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController {
    private let url: URL
    
    private lazy var webView = WKWebView().build { builder in
        builder.navigationDelegate(self)
    }
    
    init(url: URL) {
        self.url = url
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
    }
    
    override func configureLayout() {
        [webView].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func configureWebView() {
        webView.load(URLRequest(url: url))
        showProgressView()
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!
    ) {
        hideProgressView()
    }
    
    func webView(
        _ webView: WKWebView,
        didFail navigation: WKNavigation!,
        withError error: any Error
    ) {
        showToast(message: "잠시후 다시 시도하세요")
        hideProgressView()
    }
}

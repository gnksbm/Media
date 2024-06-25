//
//  BaseViewController.swift
//  Media
//
//  Created by gnksbm on 6/24/24.
//

import UIKit

class BaseViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDefaultUI()
        configureNavigation()
        configureUI()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationTitle()
    }
    
    func configureNavigationTitle() { }
    func configureNavigation() { }
    func configureUI() { }
    func configureLayout() { }
    
    private func configureDefaultUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = ""
    }
}

//
//  TrendingViewController.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

import SnapKit

final class TrendingViewController: UIViewController {
    private lazy var tableView = UITableView().build { builder in
        builder.separatorStyle(.none)
            .delegate(self)
            .dataSource(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigation()
        configureLayout()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.triangle")
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass")
        )
    }
    
    private func configureLayout() {
        [tableView].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
}

extension TrendingViewController: UITableViewDelegate { }

extension TrendingViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        .init()
    }
}

#if DEBUG
import SwiftUI
struct TrendingVCPreview: PreviewProvider {
    static var previews: some View {
        UIKitPreview {
            UINavigationController(rootViewController: TrendingViewController())
        }
    }
}
#endif

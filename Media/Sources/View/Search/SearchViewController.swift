//
//  SearchViewController.swift
//  Media
//
//  Created by gnksbm on 6/11/24.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit

final class SearchViewController: UIViewController {
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeLayout()
    ).build { builder in
        builder.dataSource(self)
            .action { $0.register(SearchCollectionViewCell.self) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureLayout()
    }
    
    private func configureNavigation() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "영화 제목을 검색해보세요."
        navigationItem.searchController = searchController
    }
    
    private func configureUI() {
        title = "영화 검색"
    }
    
    private func configureLayout() {
        [collectionView].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func makeLayout() -> UICollectionViewFlowLayout {
        UICollectionViewFlowLayout().build { builder in
            let inset: CGFloat = 10
            let cellCount: CGFloat = 3
            let horizontalInset = inset * (cellCount + 1)
            let cellWidth = (UIScreen.main.bounds.width - horizontalInset)
            / cellCount
            return builder.itemSize(
                CGSize(
                    width: cellWidth,
                    height: cellWidth * 1.3
                )
            )
            .minimumLineSpacing(inset)
            .minimumInteritemSpacing(inset)
            .sectionInset(
                UIEdgeInsets(
                    top: inset,
                    left: inset,
                    bottom: 0,
                    right: inset
                )
            )
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(
            SearchCollectionViewCell.self,
            indexPath: indexPath
        ).build { builder in
            builder
//                .configureCell(data: )
        }
    }
}

#if DEBUG
import SwiftUI
struct SearchVCPreview: PreviewProvider {
    static var previews: some View {
        let navController = UINavigationController(
            rootViewController: UIViewController()
        )
        let creditVC = SearchViewController()
        navController.pushViewController(
            creditVC,
            animated: false
        )
        return navController.preview
    }
}
#endif

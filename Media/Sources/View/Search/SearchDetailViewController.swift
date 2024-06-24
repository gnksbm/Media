//
//  SearchDetailViewController.swift
//  Media
//
//  Created by gnksbm on 6/24/24.
//

import UIKit

import SnapKit

final class SearchDetailViewController: BaseViewController {
    private var dataSource: DataSource!
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureDataSource()
        updateSnapshot()
    }
    
    private func configureLayout() {
        [collectionView].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
}

extension SearchDetailViewController {
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, _ in
            var cellCount: CGFloat
            switch CollectionViewSection.allCases[section] {
            case .similar, .recommend:
                cellCount = 3
            case .poster:
                cellCount = 2
            }
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1 / cellCount),
                    heightDimension: .fractionalHeight(1)
                )
            )
            let itemInset: CGFloat = 3
            item.contentInsets = NSDirectionalEdgeInsets(
                top: itemInset,
                leading: itemInset,
                bottom: itemInset,
                trailing: itemInset
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .fractionalWidth(1 / cellCount * 1.3)
                ),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(30)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            header.contentInsets = .init(
                top: 20,
                leading: 10,
                bottom: 0,
                trailing: 10
            )
            section.boundarySupplementaryItems = [header]
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
    
    private func configureDataSource() {
        let cellRegistration = makeCellRegistration()
        let headerRegistration = makeHeaderRegistration()
        dataSource = DataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
        dataSource.supplementaryViewProvider = 
        { collectionView, elementKind, indexPath in
            if elementKind == UICollectionView.elementKindSectionHeader {
                collectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration, 
                    for: indexPath
                )
            } else { nil }
        }
    }
    
    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections(CollectionViewSection.allCases)
        snapshot.appendItems((0...100).map({ String($0) }), toSection: .similar)
        snapshot.appendItems((101...200).map({ String($0) }), toSection: .recommend)
        snapshot.appendItems((201...300).map({ String($0) }), toSection: .poster)
        dataSource.apply(snapshot)
    }
    
    private func makeHeaderRegistration() -> HeaderRegistration {
        HeaderRegistration(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { headerView, elementKind, indexPath in
            headerView.configureHeader(
                title: CollectionViewSection.allCases[indexPath.section].title
            )
        }
    }
    
    private func makeCellRegistration() -> CellRegistration {
        CellRegistration { cell, indexPath, itemIdentifier in
            cell.backgroundColor = .init(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1
            )
        }
    }
    
    typealias DataSource =
    UICollectionViewDiffableDataSource<CollectionViewSection, String>
    
    typealias Snapshot =
    NSDiffableDataSourceSnapshot<CollectionViewSection, String>
    
    typealias CellRegistration =
    UICollectionView.CellRegistration<SearchCollectionViewCell, String>
    
    typealias HeaderRegistration =
    UICollectionView.SupplementaryRegistration<SearchDetailHeaderView>
    
    enum CollectionViewSection: CaseIterable {
        case similar, recommend, poster
        
        var title: String {
            switch self {
            case .similar:
                "비슷한 영화"
            case .recommend:
                "추천 영화"
            case .poster:
                "포스터"
            }
        }
    }
}

#if DEBUG
import SwiftUI
struct SearchDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SearchDetailViewController().preview
    }
}
#endif

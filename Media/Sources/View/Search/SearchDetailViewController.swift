//
//  SearchDetailViewController.swift
//  Media
//
//  Created by gnksbm on 6/24/24.
//

import UIKit

import SnapKit

final class SearchDetailViewController: BaseViewController {
    private let movieID: Int
    
    private var dataSource: DataSource!
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeLayout()
    )
    
    init(movieID: Int) {
        self.movieID = movieID
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        callRequest()
    }
    
    override func configureLayout() {
        [collectionView].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    override func configureNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis.circle")
        )
    }
    
    private func callRequest() {
        let group = DispatchGroup()
        var itemDic = [CollectionViewSection: [ImageEndpoint]]()
        group.enter()
        NetworkService.request(
            endpoint: SimilarEndpoint(movieID: movieID)
        ) { (response: SimilarResponse) in
            itemDic[.similar] = response.imageEndpoints
            group.leave()
        } errorHandler: { error in
            dump(error)
            group.leave()
        }
        group.enter()
        NetworkService.request(
            endpoint: RecommendEndpoint(movieID: movieID)
        ) { (response: RecommendResponse) in
            itemDic[.recommend] = response.imageEndpoints
            group.leave()
        } errorHandler: { error in
            dump(error)
            group.leave()
        }
        group.enter()
        NetworkService.request(
            endpoint: PosterEndpoint(movieID: movieID)
        ) { (response: PosterResponse) in
            itemDic[.poster] = response.imageEndpoints
            group.leave()
        } errorHandler: { error in
            dump(error)
            group.leave()
        }
        group.notify(queue: .main) { [weak self] in
            self?.updateSnapshot(itemDic: itemDic)
        }
    }
    
    private func callSimilarRequest() {
        NetworkService.request(
            endpoint: SimilarEndpoint(movieID: movieID)
        ) { (response: SimilarResponse) in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                updateSnapshot(
                    items: response.imageEndpoints,
                    toSection: .similar
                )
            }
        } errorHandler: { error in
            dump(error)
        }
    }
    
    private func callRecommendRequest() {
        NetworkService.request(
            endpoint: RecommendEndpoint(movieID: movieID)
        ) { (response: RecommendResponse) in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                updateSnapshot(
                    items: response.imageEndpoints,
                    toSection: .recommend
                )
            }
        } errorHandler: { error in
            dump(error)
        }
    }
    
    private func callPosterRequest() {
        NetworkService.request(
            endpoint: PosterEndpoint(movieID: movieID)
        ) { (response: PosterResponse) in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                updateSnapshot(
                    items: response.imageEndpoints,
                    toSection: .poster
                )
            }
        } errorHandler: { error in
            dump(error)
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
        var snapshot = Snapshot()
        snapshot.appendSections(CollectionViewSection.allCases)
        dataSource.apply(snapshot)
    }
    
    private func updateSnapshot(
        items: [ImageEndpoint],
        toSection: CollectionViewSection
    ) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(items, toSection: toSection)
        dataSource.apply(snapshot)
    }
    
    private func updateSnapshot(
        itemDic: [CollectionViewSection: [ImageEndpoint]]
    ) {
        var snapshot = dataSource.snapshot()
        itemDic.forEach { section, items in
            snapshot.appendItems(items, toSection: section)
        }
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
        CellRegistration { cell, indexPath, item in
            cell.configureCell(imageEndpoint: item)
        }
    }
    
    typealias DataSource =
    UICollectionViewDiffableDataSource<CollectionViewSection, ImageEndpoint>
    
    typealias Snapshot =
    NSDiffableDataSourceSnapshot<CollectionViewSection, ImageEndpoint>
    
    typealias CellRegistration =
    UICollectionView.CellRegistration<SearchDetailViewCVCell, ImageEndpoint>
    
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
        SearchDetailViewController(movieID: 974635).preview
    }
}
#endif

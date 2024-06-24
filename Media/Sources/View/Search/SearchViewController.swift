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

final class SearchViewController: BaseViewController {
    private var searchResult = SearchResponse(
        page: 0,
        results: [],
        totalPages: 0,
        totalResults: 0
    ) {
        didSet {
            collectionView.reloadData()
        }
    }
    private var page = 1
    
    private lazy var searchBar = UISearchBar().build { builder in
        builder.placeholder("영화 제목을 검색해보세요.")
            .delegate(self)
            .searchBarStyle(.minimal)
    }
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeLayout()
    ).build { builder in
        builder.dataSource(self)
            .delegate(self)
            .register(SearchCollectionViewCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        title = "영화 검색"
    }
    
    private func configureLayout() {
        [searchBar, collectionView].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeArea)
            make.horizontalEdges.equalTo(safeArea).inset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
    
    private func makeLayout() -> UICollectionViewFlowLayout {
        UICollectionViewFlowLayout().build { builder in
            let inset: CGFloat = 10
            let cellCount: CGFloat = 3
            let horizontalInset = inset * (cellCount + 1)
            let cellWidth = (UIScreen.main.bounds.width - horizontalInset)
            / cellCount
            return builder.scrollDirection(.vertical)
                .itemSize(
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
    
    private func callSearchRequest() {
        guard let searchTerm = searchBar.text,
              !searchTerm.isEmpty
        else { return }
        NetworkService.request(
            endpoint: SearchEndpoint(
                query: searchTerm,
                page: page
            )
        ) { (response: SearchResponse) in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                let newResults = searchResult.results + response.results
                searchResult = SearchResponse(
                    page: response.page,
                    results: newResults,
                    totalPages: response.totalPages,
                    totalResults: response.totalResults
                )
            }
        } errorHandler: { error in
            dump(error)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        searchResult = SearchResponse(
            page: 0,
            results: [],
            totalPages: 0,
            totalResults: 0
        )
        callSearchRequest()
    }
}

extension SearchViewController: UICollectionViewDelegate { 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxScrollOffset = 
        (scrollView.contentSize.height - scrollView.bounds.height)
        if scrollView.contentOffset.y > maxScrollOffset * 0.9 {
            page += 1
            callSearchRequest()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let movieID = searchResult.results[indexPath.row].id
        navigationController?.pushViewController(
            SearchDetailViewController(movieID: movieID),
            animated: true
        )
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        searchResult.results.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(
            SearchCollectionViewCell.self,
            indexPath: indexPath
        ).build { builder in
            builder.capture {
                let data = searchResult.results[indexPath.row]
                $0.configureCell(data: data)
            }
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

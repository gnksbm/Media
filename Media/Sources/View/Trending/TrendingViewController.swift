//
//  TrendingViewController.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

import SnapKit

final class TrendingViewController: BaseViewController {
    private var mediaType: TrendingRequest.MediaType = .all
    
    private var dataList = [TrendingResponse.Trending]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var genreDic = [Int: String]()
    
    private lazy var tableView = UITableView().build { builder in
        builder.separatorStyle(.none)
            .delegate(self)
            .dataSource(self)
            .register(TrendingTableViewCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callGenreRequest()
    }
    
    override func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.triangle"),
            menu: UIMenu(
                children: TrendingRequest.MediaType.allCases.map { type in
                    UIAction(title: type.title) { _ in
                        self.mediaType = type
                        self.callTrendingRequest()
                    }
                }
            )
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
    }
    
    override func configureLayout() {
        [tableView].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func callGenreRequest() {
        GenreRepository.callRequest(
            onNext: { response in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    genreDic = response.toDic
                    callTrendingRequest()
                }
            },
            onError: { [weak self] error in
                guard let self else { return }
                showToast(message: "잠시후 다시 시도하세요")
            }
        )
    }
    
    private func callTrendingRequest() {
        showProgressView()
        TrendingRepository.callRequest(
            request: TrendingRequest(
                mediaType: mediaType
            ),
            onNext: { response in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    dataList = response.results
                }
            },
            onError: { [weak self] error in
                guard let self else { return }
                showToast(message: "잠시후 다시 시도하세요")
            },
            onComplete: { [weak self] in
                guard let self else { return }
                hideProgressView()
            },
            onProgress: { [weak self] progress in
                guard let self else { return }
                updateProgress(progress: progress)
            }
        )
    }
    
    @objc private func searchButtonTapped() {
        navigationController?.pushViewController(
            SearchViewController(),
            animated: true
        )
    }
}

extension TrendingViewController: UITableViewDelegate { 
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let data = dataList[indexPath.row]
        let creditVC = CreditViewController()
        creditVC.callCreditRequest(data: data)
        navigationController?.pushViewController(
            creditVC,
            animated: true
        )
    }
}

extension TrendingViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        dataList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            cellType: TrendingTableViewCell.self,
            for: indexPath
        )
        let data = dataList[indexPath.row]
        let genre = genreDic[data.genreID ?? 0]
        cell.configureCell(data: data, genre: genre)
        cell.videoButtonHandler = { [weak self] url in
            guard let self else { return }
            if let url {
                navigationController?.pushViewController(
                    WebViewController(url: url),
                    animated: true
                )
            } else {
                showToast(message: "영상을 찾을 수 없습니다")
            }
        }
        return cell
    }
}

#if DEBUG
import SwiftUI
struct TrendingVCPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            UINavigationController(rootViewController: TrendingViewController())
        }
    }
}
#endif

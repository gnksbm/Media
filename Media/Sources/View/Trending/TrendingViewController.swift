//
//  TrendingViewController.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit

final class TrendingViewController: UIViewController {
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
            .action { $0.register(TrendingTableViewCell.self) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigation()
        configureLayout()
        callGenreRequest()
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
    
    private func callGenreRequest() {
        AF.request(GenreEndpoint())
            .responseDecodable(of: GenreResponse.self) { [weak self] response in
                guard let self else { return }
                switch response.result {
                case .success(let genreResponse):
                    genreDic = genreResponse.toDic
                    callTrendingRequest()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    private func callTrendingRequest() {
        AF.request(MediaTrendEndpoint(trendType: .all))
            .responseDecodable(of: TrendingResponse.self) { [weak self] response in
                guard let self else { return }
                switch response.result {
                case .success(let trending):
                    dataList = trending.results
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
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
        return cell
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

//
//  CreditViewController.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit

class CreditViewController: UIViewController {
    private var overView: (String, isExpanded: Bool) = ("", false) {
        didSet {
            tableView.reloadSections(
                IndexSet(integer: TableViewSection.overView.rawValue),
                with: UITableView.RowAnimation.none
            )
        }
    }
    
    private var castList = [CreditResponse.Cast]() {
        didSet {
            tableView.reloadSections(
                IndexSet(integer: TableViewSection.cast.rawValue),
                with: UITableView.RowAnimation.none
            )
        }
    }
    
    private var crewList = [CreditResponse.Cast]() {
        didSet {
            tableView.reloadSections(
                IndexSet(integer: TableViewSection.crew.rawValue),
                with: UITableView.RowAnimation.none
            )
        }
    }
    
    private let tableViewHeaderView = UIImageView().build { builder in
        builder.contentMode(.scaleAspectFill)
            .clipsToBounds(true)
    }
    
    private lazy var tableView = UITableView().build { builder in
        builder.delegate(self)
            .dataSource(self)
            .tableHeaderView(tableViewHeaderView)
            .action {
                $0.register(CreditTVCastCell.self)
                $0.register(CreditTVOverViewCell.self)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }
    
    func callCreditRequest(data: TrendingResponse.Trending) {
        AF.request(
            CreditEndpoint(
                mediaType: data.mediaType,
                creditID: data.id
            )
        )
        .responseDecodable(of: CreditResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let credit):
                overView = (data.overview, false)
                tableViewHeaderView.kf.setImage(with: data.imageEndpoint)
                castList = credit.cast
                crewList = credit.crew
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureUI() {
        title = "출연/제작"
    }
    
    private func configureLayout() {
        [tableView].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
        
        tableViewHeaderView.snp.makeConstraints { make in
            make.width.equalTo(safeArea)
            make.height.equalTo(tableViewHeaderView.snp.width).multipliedBy(0.5)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
}

extension CreditViewController: UITableViewDelegate { 
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        PaddingLabelView(
            horizontal: 20,
            vertical: 10
        ).build { builder in
            builder.text(TableViewSection.allCases[section].title)
                .font(.systemFont(ofSize: 18, weight: .semibold))
                .textColor(.secondaryLabel)
        }
    }
}

extension CreditViewController: UITableViewDataSource {
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        TableViewSection.allCases.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch TableViewSection.allCases[section] {
        case .overView:
            1
        case .cast:
            castList.count
        case .crew:
            crewList.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch TableViewSection.allCases[indexPath.section] {
        case .overView:
            let cell = tableView.dequeueReusableCell(
                cellType: CreditTVOverViewCell.self,
                for: indexPath
            )
            cell.expandHandler = { label in
                self.overView.isExpanded.toggle()
                tableView.reloadRows(
                    at: [indexPath],
                    with: .fade
                )
            }
            cell.configureCell(data: overView)
            return cell
        case .cast:
            let cell = tableView.dequeueReusableCell(
                cellType: CreditTVCastCell.self,
                for: indexPath
            )
            cell.configureCell(data: castList[indexPath.row])
            return cell
        case .crew:
            let cell = tableView.dequeueReusableCell(
                cellType: CreditTVCastCell.self,
                for: indexPath
            )
            cell.configureCell(data: crewList[indexPath.row])
            return cell
        }
    }
}
 
extension CreditViewController {
    enum TableViewSection: Int, CaseIterable {
        case overView, cast, crew
        
        var title: String {
            switch self {
            case .overView:
                "OverView"
            case .cast:
                "Cast"
            case .crew:
                "Crew"
            }
        }
    }
}

#if DEBUG
import SwiftUI
struct CreditVCPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let navController = UINavigationController(
                rootViewController: UIViewController()
            )
            let creditVC = CreditViewController()
            if let trending = TrendingResponse.mockData?.results.first {
                creditVC.callCreditRequest(data: trending)
            }
            navController.pushViewController(
                creditVC,
                animated: false
            )
            return navController
        }
    }
}
#endif

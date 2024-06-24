//
//  CreditTVOverViewCell.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

import SnapKit

final class CreditTVOverViewCell: UITableViewCell {
    var expandHandler: (UILabel) -> Void = { _ in }
    
    private let descriptionLabel = UILabel().build { builder in
        builder.textAlignment(.center)
            .font(.systemFont(ofSize: 18))
            .numberOfLines(2)
    }
    
    private lazy var expandButton = UIButton().build { builder in
        builder.tintColor(.label)
            .addTarget(
                self,
                action: #selector(expandButtonTapped),
                for: .touchUpInside
            )
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(
        data: (description: String, isExpanded: Bool)
    ) {
        descriptionLabel.text = data.description
        updateExpand(isExpanded: data.isExpanded)
    }
    
    private func configureLayout() {
        [descriptionLabel, expandButton].forEach { contentView.addSubview($0) }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(30)
        }
        
        expandButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
    
    private func updateExpand(isExpanded: Bool) {
        let imageName = isExpanded ?
        "chevron.up" : "chevron.down"
        let numberOfLines = isExpanded ?
        0 : 2
        descriptionLabel.numberOfLines = numberOfLines
        expandButton.setImage(
            UIImage(systemName: imageName)?
                .withConfiguration(
                    UIImage.SymbolConfiguration(pointSize: 25)
                ),
            for: .normal
        )
    }
    
    @objc private func expandButtonTapped() {
        expandButton.setImage(nil, for: .normal)
        expandHandler(descriptionLabel)
    }
}

#if DEBUG
import SwiftUI
struct OverViewCellPreview: PreviewProvider {
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

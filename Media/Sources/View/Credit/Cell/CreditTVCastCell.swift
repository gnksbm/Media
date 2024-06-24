//
//  CreditTVCastCell.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

import SnapKit
import Kingfisher

final class CreditTVCastCell: UITableViewCell {
    private let profileImageView = UIImageView().build { builder in
        builder.contentMode(.scaleAspectFill)
            .clipsToBounds(true)
            .backgroundColor(.tertiarySystemFill)
            .layer(\.cornerRadius)(8)
    }
    
    private let nameLabel = UILabel().build { builder in
        builder.font(.systemFont(ofSize: 18, weight: .medium))
    }
    
    private let descriptionLabel = UILabel().build { builder in
        builder.font(.systemFont(ofSize: 16, weight: .medium))
            .textColor(.tertiaryLabel)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: CreditResponse.Cast) {
        profileImageView.kf.setImage(with: data.imageEndpoint)
        nameLabel.text = data.name
        descriptionLabel.text = data.description
    }
    
    private func configureUI() {
        [profileImageView, nameLabel, descriptionLabel].forEach {
            contentView.addSubview($0)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(30)
            make.verticalEdges.equalTo(contentView).inset(10)
            make.width.equalTo(contentView).multipliedBy(0.15)
            make.height.equalTo(profileImageView.snp.width).multipliedBy(1.3)
                .priority(999)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(30)
            make.trailing.equalTo(contentView).offset(-30)
            make.bottom.equalTo(contentView.snp.centerY).offset(-5)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(nameLabel)
            make.top.equalTo(contentView.snp.centerY).offset(5)
        }
    }
    
    private func configureLayout() {
        
    }
}

#if DEBUG
import SwiftUI
struct CreditCellPreview: PreviewProvider {
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

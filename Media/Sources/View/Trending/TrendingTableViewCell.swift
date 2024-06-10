//
//  TrendingTableViewCell.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

import SnapKit

final class TrendingTableViewCell: UITableViewCell {
    private let dateLabel = UILabel().build { builder in
        builder
    }
    
    private let genreLabel = UILabel().build { builder in
        builder
    }
    
    private let cardView = TrendingCardView().build { builder in
        builder
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        [
            dateLabel,
            genreLabel,
            cardView,
        ].forEach { contentView.addSubview($0) }
        
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(dateLabel)
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView).offset(-20)
        }
    }
}

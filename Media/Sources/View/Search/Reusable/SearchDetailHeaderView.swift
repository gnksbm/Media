//
//  SearchDetailHeaderView.swift
//  Media
//
//  Created by gnksbm on 6/24/24.
//

import UIKit

import SnapKit

final class SearchDetailHeaderView: BaseCollectionViewReusableView {
    private let titleLabel = UILabel().build { builder in
        builder.font(.systemFont(ofSize: 22, weight: .heavy))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    func configureHeader(title: String) {
        titleLabel.text = title
    }
    
    override func configureLayout() {
        [titleLabel].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.horizontalEdges.bottom.equalTo(self)
        }
    }
}

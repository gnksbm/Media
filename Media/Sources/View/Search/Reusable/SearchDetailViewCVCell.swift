//
//  SearchDetailViewCVCell.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import UIKit

import Kingfisher

final class SearchDetailViewCVCell: UICollectionViewCell {
    private let posterImageView = UIImageView().build { builder in
        builder.contentMode(.scaleAspectFill)
            .backgroundColor(.tertiarySystemFill)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(imageEndpoint: ImageEndpoint) {
        posterImageView.kf.setImage(with: imageEndpoint)
    }
    
    private func configureUI() {
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    private func configureLayout() {
        [posterImageView].forEach { contentView.addSubview($0) }
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}

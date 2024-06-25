//
//  SearchDetailViewCVCell.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import UIKit

final class SearchDetailViewCVCell: BaseCollectionViewCell {
    private let posterImageView = UIImageView().build { builder in
        builder.contentMode(.scaleAspectFill)
            .backgroundColor(.tertiarySystemFill)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    func configureCell(imageEndpoint: ImageEndpoint) {
        posterImageView.setImage(with: imageEndpoint)
    }
    
    override func configureUI() {
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    override func configureLayout() {
        [posterImageView].forEach { contentView.addSubview($0) }
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}

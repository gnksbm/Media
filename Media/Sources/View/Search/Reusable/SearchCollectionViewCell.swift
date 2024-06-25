//
//  SearchCollectionViewCell.swift
//  Media
//
//  Created by gnksbm on 6/11/24.
//

import UIKit

import SnapKit
import Kingfisher

final class SearchCollectionViewCell: BaseCollectionViewCell {
    private let posterImageView = UIImageView().build { builder in
        builder.contentMode(.scaleAspectFill)
            .backgroundColor(.tertiarySystemFill)
    }
    
    func configureCell(data: SearchResponse.SearchResult) {
        posterImageView.kf.setImage(with: data.imageEndpoint)
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

#if DEBUG
import SwiftUI
struct SearchCVCellPreview: PreviewProvider {
    static var previews: some View {
        SearchCollectionViewCell().preview
            .frame(width: 100, height: 130)
    }
}
#endif

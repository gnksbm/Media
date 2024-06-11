//
//  SearchCollectionViewCell.swift
//  Media
//
//  Created by gnksbm on 6/11/24.
//

import UIKit

import SnapKit
import Kingfisher

final class SearchCollectionViewCell: UICollectionViewCell {
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
    
//    func configureCell(data: ) {
//        posterImageView.kf.setImage(with: data.)
//    }
    
    private func configureUI() {
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    private func configureLayout() {
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

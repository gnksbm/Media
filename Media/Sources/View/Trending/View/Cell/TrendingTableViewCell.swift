//
//  TrendingTableViewCell.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

import SnapKit

final class TrendingTableViewCell: BaseTableViewCell {
    private let dateLabel = UILabel().build { builder in
        builder.textColor(.secondaryLabel)
    }
    
    private let genreLabel = UILabel().build { builder in
        builder.font(.systemFont(ofSize: 22, weight: .heavy))
    }
    
    private lazy var cardShadowView = UIView().build { builder in
        builder.layer.shadowRadius(10)
            .layer.shadowOffset(CGSize(width: 0, height: 5))
            .layer.borderColor(
                UIColor.secondarySystemGroupedBackground.cgColor
            )
            .layer.shadowOpacity(0.25)
    }
    
    private let cardView = TrendingCardView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(data: TrendingResponse.Trending, genre: String?) {
        dateLabel.text = data.visibleDate
        genreLabel.text = "#\(genre ?? "")"
        cardView.configureView(data: data)
    }
    
    override func configureUI() {
        selectionStyle = .none
    }
    
    override func configureLayout() {
        [
            dateLabel,
            genreLabel,
            cardShadowView,
        ].forEach { contentView.addSubview($0) }
        
        cardShadowView.addSubview(cardView)
        
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.leading.trailing.equalTo(dateLabel)
        }
        
        cardShadowView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
            make.width.height.equalTo(contentView.snp.width)
            make.bottom.equalTo(contentView).offset(-20)
        }
        
        cardView.snp.makeConstraints { make in
            make.edges.equalTo(cardShadowView).inset(20)
        }
    }
}

#if DEBUG
import SwiftUI
struct TrendingTVCellPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            UINavigationController(rootViewController: TrendingViewController())
        }
    }
}
#endif

//
//  TrendingCardView.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

import SnapKit

final class TrendingCardView: BaseView {
    private let mainImageView = UIImageView().build { builder in
        builder.contentMode(.scaleAspectFill)
            .backgroundColor(.tertiarySystemFill)
            .clipsToBounds(true)
    }
    
    private let clipboardButton = UIButton().build { builder in
        builder.configuration(.bordered())
            .configuration(\.baseBackgroundColor)(.systemBackground)
            .configuration(\.baseForegroundColor)(.label)
            .configuration(\.image)(UIImage(systemName: "paperclip"))
            .configuration(\.preferredSymbolConfigurationForImage)(
                UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 16))
            )
            .configuration(\.cornerStyle)(.capsule)
            .configuration(\.titlePadding)(.zero)
    }
    
    private let gradeDescriptionLabel = PaddingLabelView(
        padding: 7
    ).build { builder in
        builder.text("평점")
            .backgroundColor(
                UIColor(
                    red: 0.3468087614,
                    green: 0.3369399607,
                    blue: 0.8411970139,
                    alpha: 1
                )
            )
            .textColor(.white)
            .font(.systemFont(ofSize: 15))
    }
    
    private let gradeLabel = PaddingLabelView(
        horizontal: 12,
        vertical: 7
    ).build { builder in
        builder.backgroundColor(.systemBackground)
            .font(.systemFont(ofSize: 16, weight: .regular))
    }
    
    private let titleLabel = UILabel().build { builder in
        builder.font(.systemFont(ofSize: 22))
    }
    
    private let descriptionLabel = UILabel().build { builder in
        builder.textColor(.secondaryLabel)
    }
    
    private let dividerView = UIView().build { builder in
        builder.backgroundColor(.label)
    }
    
    private let detailButton = UIButton().build { builder in
        builder.configuration(.borderless())
            .configuration(\.baseBackgroundColor)(.systemBackground)
            .configuration(\.baseForegroundColor)(.label)
            .configuration(\.image)(UIImage(systemName: "chevron.right"))
            .configuration(\.imagePlacement)(.trailing)
            .configuration(\.cornerStyle)(.capsule)
            .configuration(\.titlePadding)(.zero)
            .attributedTitle(
                "자세히 보기",
                attributes: [
                    .font : UIFont.systemFont(ofSize: 15)
                ]
            )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        detailButton.titleLabel?.numberOfLines = 1
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let titleWidth = detailButton.titleLabel?.bounds.width,
           let imageWidth = detailButton.imageView?.bounds.width {
            let imagePadding = 
            detailButton.bounds.width - titleWidth - imageWidth
            detailButton.configuration?.imagePadding = imagePadding
        }
    }
    
    func configureView(data: TrendingResponse.Trending) {
        mainImageView.setImage(with: data.imageEndpoint)
        gradeLabel.text = data.grade
        titleLabel.text = data.title
        descriptionLabel.text = data.overview
    }
    
    override func configureUI() {
        backgroundColor = .systemBackground
        clipsToBounds = true
        layer.cornerRadius = 20
    }
    
    override func configureLayout() {
        [
            mainImageView,
            clipboardButton,
            gradeDescriptionLabel,
            gradeLabel,
            titleLabel,
            descriptionLabel,
            dividerView,
            detailButton
        ].forEach { addSubview($0) }
        
        let insetVolume = 20
        
        mainImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self)
        }
        
        clipboardButton.snp.makeConstraints { make in
            make.top.equalTo(mainImageView).offset(insetVolume)
            make.trailing.equalTo(mainImageView).offset(-insetVolume)
        }
        
        gradeDescriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView).offset(-insetVolume)
            make.leading.equalTo(mainImageView).offset(insetVolume)
        }
        
        gradeLabel.snp.makeConstraints { make in
            make.leading.equalTo(gradeDescriptionLabel.snp.trailing)
            make.top.bottom.equalTo(gradeDescriptionLabel)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(insetVolume)
            make.horizontalEdges.equalTo(self).inset(insetVolume)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(insetVolume / 4)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(insetVolume)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        detailButton.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.horizontalEdges.equalTo(titleLabel)
            make.bottom.equalTo(self).offset(-insetVolume / 2)
        }
    }
}

#if DEBUG
import SwiftUI
struct TrendingCardViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            UINavigationController(rootViewController: TrendingViewController())
        }
    }
}
#endif

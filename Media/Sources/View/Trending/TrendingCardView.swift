//
//  TrendingCardView.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

import SnapKit

final class TrendingCardView: UIView {
    private let mainImageView = UIImageView().build { builder in
        builder
    }
    
    private let clipboardButton = UIButton().build { builder in
        builder
    }
    
    private let gradeDescriptionLabel = UILabel().build { builder in
        builder
    }
    
    private let gradeLabel = UILabel().build { builder in
        builder
    }
    
    private let titleLabel = UILabel().build { builder in
        builder
    }
    
    private let descriptionLabel = UILabel().build { builder in
        builder
    }
    
    private let dividerView = UIView().build { builder in
        builder
    }
    
    private let detailButton = UIButton().build { builder in
        builder
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
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
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(insetVolume)
            make.horizontalEdges.equalTo(self).inset(insetVolume)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(insetVolume / 2)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(insetVolume)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        detailButton.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(insetVolume / 2)
            make.horizontalEdges.equalTo(titleLabel)
            make.bottom.equalTo(self).offset(insetVolume / 2)
        }
    }
}

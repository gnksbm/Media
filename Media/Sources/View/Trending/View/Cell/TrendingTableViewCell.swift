//
//  TrendingTableViewCell.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

import SnapKit

final class TrendingTableViewCell: BaseTableViewCell {
    var videoURL: URL?
    var videoButtonHandler: ((URL?) -> Void)?
    private var dataRequest: AnyDataRequest<VideoResponse>?
    
    private let dateLabel = UILabel().build { builder in
        builder.textColor(.secondaryLabel)
    }
    
    private let genreLabel = UILabel().build { builder in
        builder.font(.systemFont(ofSize: 22, weight: .heavy))
    }
    
    private lazy var videoButton = UIButton().build { builder in
        builder.configuration(.plain())
            .configuration.image(
                UIImage(systemName: "video.circle")
            )
            .configuration.baseForegroundColor(.red)
            .configuration.preferredSymbolConfigurationForImage(
                UIImage.SymbolConfiguration(pointSize: 22)
            )
            .addTarget(
                self,
                action: #selector(videoButtonTapped),
                for: .touchUpInside
            )
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
        dataRequest?.cancel()
        videoButtonHandler = nil
    }
    
    func configureCell(data: TrendingResponse.Trending, genre: String?) {
        dateLabel.text = data.visibleDate
        genreLabel.text = "#\(genre ?? "")"
        cardView.configureView(data: data)
        
        dataRequest = VideoRepository.callRequest(
            request: VideoRequest(
                seriesID: "\(data.id)",
                mediaType: data.mediaType
            ),
            onNext: {
                [weak self] response in
                guard let self else { return }
                videoURL = response.youtubeURL
                videoButton.isEnabled = true
            },
            onError: { [weak self] error in
                guard let self else { return }
                videoURL = nil
                videoButton.isEnabled = false
            }
        )
    }
    
    override func configureUI() {
        selectionStyle = .none
    }
    
    override func configureLayout() {
        [
            dateLabel,
            genreLabel,
            cardShadowView,
            videoButton
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
        
        videoButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel)
            make.trailing.equalTo(contentView).inset(20)
            make.bottom.equalTo(genreLabel)
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
    
    @objc func videoButtonTapped() {
        videoButtonHandler?(videoURL)
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

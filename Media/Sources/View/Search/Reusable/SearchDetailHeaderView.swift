//
//  SearchDetailHeaderView.swift
//  Media
//
//  Created by gnksbm on 6/24/24.
//

import UIKit

import SnapKit

final class SearchDetailHeaderView: UICollectionReusableView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    func configureHeader(title: String) {
        titleLabel.text = title
    }
    
    private func configureUI() {
        [titleLabel].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.horizontalEdges.bottom.equalTo(self)
        }
    }
}

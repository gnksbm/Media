//
//  BaseCollectionViewCell.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() { }
    func configureLayout() { }
}

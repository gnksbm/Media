//
//  PaddingLabel.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

@dynamicMemberLookup
final class PaddingLabelView: UIView {
    private lazy var topConstraint = innerLabel.topAnchor.constraint(
        equalTo: topAnchor,
        constant: 0
    )
    private lazy var leadingConstraint = innerLabel.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: 0
    )
    private lazy var trailingConstraint = innerLabel.trailingAnchor.constraint(
        equalTo: trailingAnchor,
        constant: 0
    )
    private lazy var bottomConstraint = innerLabel.bottomAnchor.constraint(
        equalTo: bottomAnchor,
        constant: 0
    )
    
    private let innerLabel = PaddingLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    convenience init(
        padding: CGFloat
    ) {
        self.init()
        self.topConstraint.constant = padding
        self.leadingConstraint.constant = padding
        self.trailingConstraint.constant = -padding
        self.bottomConstraint.constant = -padding
    }
    
    convenience init(
        horizontal: CGFloat = 0,
        vertical: CGFloat = 0
    ) {
        self.init()
        self.topConstraint.constant = vertical
        self.leadingConstraint.constant = horizontal
        self.trailingConstraint.constant = -horizontal
        self.bottomConstraint.constant = -vertical
    }
    
    convenience init(
        topInset: CGFloat = 0,
        leadingInset: CGFloat = 0,
        trailingInset: CGFloat = 0,
        bottomInset: CGFloat = 0
    ) {
        self.init()
        self.topConstraint.constant = topInset
        self.leadingConstraint.constant = leadingInset
        self.trailingConstraint.constant = -trailingInset
        self.bottomConstraint.constant = -bottomInset
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    subscript<Value>(
        dynamicMember keyPath: ReferenceWritableKeyPath<UILabel, Value>
    ) -> Value {
        get {
            innerLabel[keyPath: keyPath]
        }
        set {
            innerLabel[keyPath: keyPath] = newValue
        }
    }
    
    private func configureUI() {
        innerLabel.backgroundColorChanged = { color in
            self.backgroundColor = color
        }
    }
    
    private func configureLayout() {
        addSubview(innerLabel)
        innerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            bottomConstraint
        ])
    }
}

fileprivate final class PaddingLabel: UILabel {
    var backgroundColorChanged: (UIColor?) -> Void = { _ in }
    
    override var backgroundColor: UIColor? {
        willSet {
            backgroundColorChanged(newValue)
        }
    }
}

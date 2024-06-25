//
//  Builder.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import UIKit

protocol Buildable { }

extension Buildable where Self: AnyObject {
    func build(
        _ block: ((_ builder: Builder<Self>) -> Builder<Self>)
    ) -> Self {
        block(Builder(self)).finalize()
    }
}

extension NSObject: Buildable { }

@dynamicMemberLookup
struct Builder<Base: AnyObject> {
    private let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
    /// Base의 프로퍼티 값 설정  ex) builder.text("a")
    subscript<Value>(
        dynamicMember keyPath: ReferenceWritableKeyPath<Base, Value>
    ) -> (Value) -> Builder<Base> {
        { newValue in
            base[keyPath: keyPath] = newValue
            return self
        }
    }
    /// Reference타입 중첩 프로퍼티 값 설정 ex) builder.layer(\.cornerRadius)(10)
    subscript<Property, NestedValue>(
        dynamicMember keyPath: KeyPath<Base, Property>
    ) -> (_ nestedKeyPath: ReferenceWritableKeyPath<Property, NestedValue>
    ) -> (_ newValue: NestedValue) -> Builder<Base> {
        { nestedKeyPath in
            { newValue in
                base[keyPath: keyPath.appending(path: nestedKeyPath)] = newValue
                return Builder(base)
            }
        }
    }
    /// Value타입 옵셔널 중첩 프로퍼티 값 설정 ex) builder.configuration(\.baseBackgroundColor)(.black)
    subscript<Value, NestedValue>(
        dynamicMember keyPath: KeyPath<Base, Value?>
    ) -> (WritableKeyPath<Value, NestedValue>
    ) -> (NestedValue
    ) -> Builder<Base> {
        { nestedKeyPath in
            { newValue in
                var value = base[keyPath: keyPath]
                value?[keyPath: nestedKeyPath] = newValue
                return self
            }
        }
    }
    
    func capture(_ block: (_ base: Base) -> Void) -> Builder<Base> {
        block(base)
        return Builder(base)
    }
    
    fileprivate func finalize() -> Base {
        base
    }
}

extension Builder where Base: UIView {
    func setContentHuggingPriority(
        _ priority: UILayoutPriority,
        for axis: NSLayoutConstraint.Axis
    ) -> Builder<Base> {
        base.setContentHuggingPriority(
            priority,
            for: axis
        )
        return self
    }
    
    func setContentCompressionResistancePriority(
        _ priority: UILayoutPriority,
        for axis: NSLayoutConstraint.Axis
    ) -> Builder<Base> {
        base.setContentHuggingPriority(
            priority,
            for: axis
        )
        return self
    }
}

extension Builder where Base: UIButton {
    func addTarget(
        _ target: Any?,
        action: Selector,
        for controlEvents: UIControl.Event
    ) -> Builder<Base> {
        base.addTarget(target, action: action, for: controlEvents)
        return self
    }
    
    func attributedTitle(
        _ title: String,
        attributes: [NSAttributedString.Key: Any]
    ) -> Builder<Base> {
        if base.configuration == nil {
            let attributedString = NSAttributedString(
                string: title,
                attributes: attributes
            )
            base.setAttributedTitle(attributedString, for: .normal)
        } else {
            let container = AttributeContainer(attributes)
            base.configuration?.attributedTitle = AttributedString(
                title,
                attributes: container
            )
        }
        return self
    }
}

extension Builder where Base: UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) -> Builder<Base> {
        base.register(cellClass)
        return self
    }
}

extension Builder where Base: UICollectionView {
    func register<T: UICollectionViewCell>(
        _ cellClass: T.Type
    ) -> Builder<Base> {
        base.register(cellClass)
        return self
    }
}

extension Builder where Base: UIControl {
    func addTarget(
        _ target: Any?,
        action: Selector,
        for controlEvents: UIControl.Event
    ) -> Builder<Base> {
        base.addTarget(target, action: action, for: controlEvents)
        return self
    }
}

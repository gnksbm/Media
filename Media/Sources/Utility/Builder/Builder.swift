//
//  Builder.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

@dynamicMemberLookup
struct Builder<Base: AnyObject> {
    private let base: Base
    
    subscript<Value>(
        dynamicMember keyPath: ReferenceWritableKeyPath<Base, Value>
    ) -> ((Value) -> Builder<Base>) {
        { value in
            base[keyPath: keyPath] = value
            return Builder(base)
        }
    }
    
    init(_ base: Base) {
        self.base = base
    }
    
    func build() -> Base {
        base
    }
    
    func action(_ block: (Base) -> Void) -> Builder<Base> {
        block(base)
        return Builder(base)
    }
}

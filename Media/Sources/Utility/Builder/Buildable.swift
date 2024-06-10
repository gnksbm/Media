//
//  Buildable.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

protocol Buildable { }

extension Buildable where Self: AnyObject {
    var builder: Builder<Self> {
        Builder(self)
    }
    
    func build(
        _ block: ((_ builder: Builder<Self>) -> Builder<Self>)
    ) -> Self {
        block(builder).build()
    }
}

extension NSObject: Buildable { }

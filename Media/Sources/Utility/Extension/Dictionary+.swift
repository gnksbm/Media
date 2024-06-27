//
//  Dictionary+.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import Foundation

extension Dictionary where Key == String, Value == String {
    static let tmdbAPIKey = ["api_key": String.tmdbAPIKey]
    
    static func toStringDictionary<T>(_ object: T) -> Self {
        Dictionary(
            uniqueKeysWithValues: Mirror(reflecting: object).children
                .compactMap { (label, value) in
                    guard let key = label else { return nil }
                    return (key, "\(value)")
                }
        )
    }
    
    func withTMDBAPIKey() -> Self {
        merging(.tmdbAPIKey) { $1 }
    }
}

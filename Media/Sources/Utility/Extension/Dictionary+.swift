//
//  Dictionary+.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import Foundation

extension Dictionary where Key == String, Value == String {
    static let tmdbAPIKey = ["api_key": String.tmdbAPIKey]
    
    func withTMDBAPIKey() -> Self {
        merging(.tmdbAPIKey) { $1 }
    }
}

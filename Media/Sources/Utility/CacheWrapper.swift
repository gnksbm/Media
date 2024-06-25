//
//  CacheWrapper.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import Foundation

@propertyWrapper
struct CacheWrapper {
    private static let cache = NSCache<NSURL, NSData>()
    
    private let url: URL
    
    var wrappedValue: Data? {
        get {
            CacheWrapper.cache.object(forKey: url as NSURL) as? Data
        }
        set {
            guard let nsData = newValue as? NSData else { return }
            CacheWrapper.cache.setObject(nsData, forKey: url as NSURL)
        }
    }
    
    init(url: URL) {
        self.url = url
    }
}

//
//  SearchEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/11/24.
//

import Foundation

struct SearchEndpoint: TMDBEndpoint {
    let request: SearchRequest
    
    var path: String { "/search/movie" }
    
    var queries: [String : String]? {
        .toStringDictionary(request).withTMDBAPIKey()
    }
}

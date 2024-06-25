//
//  SearchEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/11/24.
//

import Foundation

struct SearchEndpoint: TMDBEndpoint {
    let query: String
    let page: Int
    
    var httpMethod: HTTPMethod { .get }
    
    var path: String { "/3/search/movie" }
    
    var queries: [String : String]? {
        [
            "query": query,
            "page": "\(page)",
        ].withTMDBAPIKey()
    }
}

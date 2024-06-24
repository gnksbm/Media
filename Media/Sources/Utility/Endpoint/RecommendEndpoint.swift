//
//  RecommendEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import Foundation

struct RecommendEndpoint: TMDBEndpoint {
    let movieID: Int
    
    var httpMethod: HTTPMethod { .get }
    var path: String { "/3/movie/\(movieID)/recommendations" }
    var header: [String : String]? {
        ["Content-Type": "application/json"]
    }
    var queries: [String : String]? {
        [
            "api_key": .tmdbAPIKey,
            "language": "en-US",
            "page": "1"
        ]
    }
}

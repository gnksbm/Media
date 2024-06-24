//
//  SimilarEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/24/24.
//

import Foundation

struct SimilarEndpoint: TMDBEndpoint {
    let movieID: Int
    
    var httpMethod: HTTPMethod { .get }
    var path: String { "/3/movie/\(movieID)/similar" }
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

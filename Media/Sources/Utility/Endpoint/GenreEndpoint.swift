//
//  GenreEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

struct GenreEndpoint: TMDBEndpoint {
    var httpMethod: HTTPMethod { .get }
    
    var path: String { "/3/genre/movie/list" }
    
    var queries: [String : String]? {
        [
            "api_key": .tmdbAPIKey,
            "language": "ko"
        ]
    }
}

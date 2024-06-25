//
//  PosterEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import Foundation

struct PosterEndpoint: TMDBEndpoint {
    let movieID: Int
    
    var httpMethod: HTTPMethod { .get }
    var path: String { "/3/movie/\(movieID)/images" }
    var header: [String : String]? {
        ["Content-Type": "application/json"]
    }
    var queries: [String : String]? { .tmdbAPIKey }
}

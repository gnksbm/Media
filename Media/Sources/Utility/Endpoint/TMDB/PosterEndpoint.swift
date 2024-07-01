//
//  PosterEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import Foundation

struct PosterEndpoint: TMDBEndpoint {
    let request: PosterRequest
    
    var path: String { "/movie/\(request.movieID)/images" }
    var queries: [String : String]? { .tmdbAPIKey }
}

//
//  GenreEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

struct GenreEndpoint: TMDBEndpoint {
    let request: GenreRequest
    
    var path: String { "/genre/movie/list" }
    var queries: [String : String]? {
        .toStringDictionary(request).withTMDBAPIKey()
    }
    
    init(request: GenreRequest = GenreRequest()) {
        self.request = request
    }
}

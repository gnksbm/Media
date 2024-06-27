//
//  RecommendEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import Foundation

struct RecommendEndpoint: TMDBEndpoint {
    let request: RecommendRequest
    
    var path: String { "/movie/\(request.movieID)/recommendations" }
    var queries: [String : String]? {
        var dic = Dictionary.toStringDictionary(request)
        .withTMDBAPIKey()
        _ = dic.removeValue(forKey: "movieID")
        return dic
    }
}

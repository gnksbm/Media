//
//  SimilarEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/24/24.
//

import Foundation

struct SimilarEndpoint: TMDBEndpoint {
    let request: SimilarRequest
    
    var path: String { "/movie/\(request.movieID)/similar" }
    var queries: [String : String]? {
        var dic = Dictionary.toStringDictionary(request)
        .withTMDBAPIKey()
        _ = dic.removeValue(forKey: "movieID")
        return dic
    }
}

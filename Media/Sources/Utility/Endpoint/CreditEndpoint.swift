//
//  CreditEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

struct CreditEndpoint: TMDBEndpoint {
    let mediaType: TrendingResponse.MediaType
    let creditID: Int
    
    var httpMethod: HTTPMethod { .get }
    
    var path: String { "/3/\(mediaType.rawValue)/\(creditID)/credits" }
    
    var queries: [String : String]? {
        [
            "api_key": .tmdbAPIKey,
        ]
    }
}

//
//  CreditEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

struct CreditEndpoint: TMDBEndpoint {
    let request: CreditRequest
    
    var path: String {
        "/\(request.mediaType.rawValue)/\(request.creditID)/credits"
    }
    
    var queries: [String : String]? { .tmdbAPIKey }
}

//
//  RecommendRepository.swift
//  Media
//
//  Created by gnksbm on 6/27/24.
//

import Foundation

final class RecommendRepository {
    private init() { }
    
    static func callRequest(
        request: RecommendRequest,
        _ completionHandler: @escaping (RecommendResponse) -> Void,
        errorHandler: @escaping (Error) -> Void
    ) {
        NetworkService.request(
            endpoint: RecommendEndpoint(request: request),
            completionHandler,
            errorHandler: errorHandler
        )
    }
}


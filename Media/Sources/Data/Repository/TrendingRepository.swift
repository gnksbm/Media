//
//  TrendingRepository.swift
//  Media
//
//  Created by gnksbm on 6/27/24.
//

import Foundation

final class TrendingRepository {
    private init() { }
    
    static func callRequest(
        request: TrendingRequest,
        _ completionHandler: @escaping (TrendingResponse) -> Void,
        errorHandler: @escaping (Error) -> Void
    ) {
        NetworkService.request(
            endpoint: TrendingEndpoint(request: request),
            completionHandler,
            errorHandler: errorHandler
        )
    }
}

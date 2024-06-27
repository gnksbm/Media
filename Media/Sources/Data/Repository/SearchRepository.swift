//
//  SearchRepository.swift
//  Media
//
//  Created by gnksbm on 6/27/24.
//

import Foundation

final class SearchRepository {
    private init() { }
    
    static func callRequest(
        request: SearchRequest,
        _ completionHandler: @escaping (SearchResponse) -> Void,
        errorHandler: @escaping (Error) -> Void
    ) {
        NetworkService.request(
            endpoint: SearchEndpoint(request: request),
            completionHandler,
            errorHandler: errorHandler
        )
    }
}

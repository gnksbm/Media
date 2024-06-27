//
//  SimilarRepository.swift
//  Media
//
//  Created by gnksbm on 6/27/24.
//

import Foundation

final class SimilarRepository {
    private init() { }
    
    static func callRequest(
        request: SimilarRequest,
        _ completionHandler: @escaping (SimilarResponse) -> Void,
        errorHandler: @escaping (Error) -> Void
    ) {
        NetworkService.request(
            endpoint: SimilarEndpoint(request: request),
            completionHandler,
            errorHandler: errorHandler
        )
    }
}

//
//  PosterRepository.swift
//  Media
//
//  Created by gnksbm on 6/27/24.
//

import Foundation

final class PosterRepository {
    private init() { }
    
    static func callRequest(
        request: PosterRequest,
        _ completionHandler: @escaping (PosterResponse) -> Void,
        errorHandler: @escaping (Error) -> Void
    ) {
        NetworkService.request(
            endpoint: PosterEndpoint(request: request),
            completionHandler,
            errorHandler: errorHandler
        )
    }
}

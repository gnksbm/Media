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
        onNext: @escaping (TrendingResponse) -> Void,
        onError: @escaping (Error) -> Void = { _ in },
        onComplete: @escaping () -> Void = { }
    ) {
        NetworkService.shared.request(
            endpoint: TrendingEndpoint(request: request)
        )
        .decode(type: TrendingResponse.self)
        .receive(
            onNext: onNext,
            onError: onError,
            onComplete: onComplete
        )
    }
}

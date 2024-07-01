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
        onNext: @escaping (RecommendResponse) -> Void,
        onError: @escaping (Error) -> Void = { _ in },
        onComplete: @escaping () -> Void = { }
    ) {
        NetworkService.shared.request(
            endpoint: RecommendEndpoint(request: request)
        )
        .decode(type: RecommendResponse.self)
        .receive(
            onNext: onNext,
            onError: onError,
            onComplete: onComplete
        )
    }
}


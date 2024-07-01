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
        onNext: @escaping (SimilarResponse) -> Void,
        onError: @escaping (Error) -> Void = { _ in },
        onComplete: @escaping () -> Void = { }
    ) {
        NetworkService.shared.request(
            endpoint: SimilarEndpoint(request: request)
        )
        .decode(type: SimilarResponse.self)
        .receive(
            onNext: onNext,
            onError: onError,
            onComplete: onComplete
        )
    }
}

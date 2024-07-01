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
        onNext: @escaping (PosterResponse) -> Void,
        onError: @escaping (Error) -> Void = { _ in },
        onComplete: @escaping () -> Void = { }
    ) {
        NetworkService.shared.request(
            endpoint: PosterEndpoint(request: request)
        )
        .decode(type: PosterResponse.self)
        .receive(
            onNext: onNext,
            onError: onError,
            onComplete: onComplete
        )
    }
}

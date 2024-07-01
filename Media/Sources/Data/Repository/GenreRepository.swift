//
//  GenreRepository.swift
//  Media
//
//  Created by gnksbm on 6/27/24.
//

import Foundation

final class GenreRepository {
    private init() { }
    
    static func callRequest(
        onNext: @escaping (GenreResponse) -> Void,
        onError: @escaping (Error) -> Void = { _ in },
        onComplete: @escaping () -> Void = { }
    ) {
        NetworkService.shared.request(
            endpoint: GenreEndpoint()
        )
        .decode(type: GenreResponse.self)
        .receive(
            onNext: onNext,
            onError: onError,
            onComplete: onComplete
        )
    }
}

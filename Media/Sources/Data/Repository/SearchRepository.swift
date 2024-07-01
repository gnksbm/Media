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
        onNext: @escaping (SearchResponse) -> Void,
        onError: @escaping (Error) -> Void = { _ in },
        onComplete: @escaping () -> Void = { },
        onProgress: @escaping (Double) -> Void = { _ in }
    ) {
        NetworkService.shared.request(
            endpoint: SearchEndpoint(request: request)
        )
        .decode(type: SearchResponse.self)
        .receive(
            onNext: onNext,
            onError: onError,
            onComplete: onComplete
        )
        .onProgress(onProgress)
    }
}

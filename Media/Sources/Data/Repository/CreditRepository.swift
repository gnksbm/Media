//
//  CreditRepository.swift
//  Media
//
//  Created by gnksbm on 6/27/24.
//

import Foundation

final class CreditRepository {
    private init() { }
    
    static func callRequest(
        request: CreditRequest,
        onNext: @escaping (CreditResponse) -> Void,
        onError: @escaping (Error) -> Void = { _ in },
        onComplete: @escaping () -> Void = { },
        onProgress: @escaping (Double) -> Void = { _ in }
    ) {
        NetworkService.shared.request(
            endpoint: CreditEndpoint(request: request)
        )
        .decode(type: CreditResponse.self)
        .receive(
            onNext: onNext,
            onError: onError,
            onComplete: onComplete
        )
        .onProgress(onProgress)
    }
}

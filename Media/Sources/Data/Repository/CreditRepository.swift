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
        _ completionHandler: @escaping (CreditResponse) -> Void,
        errorHandler: @escaping (Error) -> Void
    ) {
        NetworkService.request(
            endpoint: CreditEndpoint(request: request),
            completionHandler,
            errorHandler: errorHandler
        )
    }
}

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
        _ completionHandler: @escaping (GenreResponse) -> Void,
        errorHandler: @escaping (Error) -> Void
    ) {
        NetworkService.request(
            endpoint: GenreEndpoint(),
            completionHandler,
            errorHandler: errorHandler
        )
    }
}

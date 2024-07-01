//
//  TMDBEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

protocol TMDBEndpoint: HTTPSEndpointRepresentable { 
    var version: Int { get }
}

extension TMDBEndpoint {
    var version: Int { 3 }
    var host: String { "api.themoviedb.org" }
    var httpMethod: HTTPMethod { .get }
    
    func toURL() -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "/\(version)\(path)"
        components.port = port
        components.queryItems = queries?.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        return components.url
    }
}

//
//  ImageEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

import Kingfisher

struct ImageEndpoint: HTTPSEndpointRepresentable, Resource {
    let posterPath: String
    
    var host: String { "image.tmdb.org" }
    
    var httpMethod: HTTPMethod { .get }
    
    var path: String {
        "/t/p/w500/\(posterPath)"
    }
}

extension ImageEndpoint {
    var cacheKey: String {
        posterPath
    }
    
    var downloadURL: URL {
        do {
            return try asURL()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

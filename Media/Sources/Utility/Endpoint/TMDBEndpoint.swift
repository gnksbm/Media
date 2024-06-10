//
//  TMDBEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

protocol TMDBEndpoint: HTTPSEndpointRepresentable { }

extension TMDBEndpoint {
    var host: String { "api.themoviedb.org" }
}

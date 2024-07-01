//
//  YouTubeWatchEndpoint.swift
//  Media
//
//  Created by gnksbm on 7/1/24.
//

import Foundation

struct YouTubeWatchEndpoint: YouTubeEndpoint {
    let request: YouTubeWatchRequest
    var httpMethod: HTTPMethod { .get }
    var path: String { "/watch" }
    var queries: [String : String]? {
        ["v": request.key]
    }
}

struct YouTubeWatchRequest {
    let key: String
}

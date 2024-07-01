//
//  VideoResponse.swift
//  Media
//
//  Created by gnksbm on 7/1/24.
//

import Foundation

struct VideoResponse: Codable {
    let id: Int
    let results: [Result]
}

extension VideoResponse {
    var youtubeURL: URL? {
        results
            .compactMap {
                YouTubeWatchEndpoint(request: YouTubeWatchRequest(key: $0.key))
                    .toURL()
            }
            .first
    }
}

extension VideoResponse {
    struct Result: Codable {
        let iso639_1, iso3166_1, name, key: String
        let site: String
        let size: Int
        let type: String
        let official: Bool
        let publishedAt, id: String
        
        enum CodingKeys: String, CodingKey {
            case iso639_1 = "iso_639_1"
            case iso3166_1 = "iso_3166_1"
            case name, key, site, size, type, official
            case publishedAt = "published_at"
            case id
        }
    }
}

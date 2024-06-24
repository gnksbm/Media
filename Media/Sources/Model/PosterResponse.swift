//
//  PosterResponse.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import Foundation

struct PosterResponse: Codable {
    let backdrops: [Backdrop]
    let id: Int
    let logos, posters: [Backdrop]
}

extension PosterResponse {
    var imageEndpoints: [ImageEndpoint] {
        backdrops.map { ImageEndpoint(posterPath: $0.filePath) } +
        logos.map { ImageEndpoint(posterPath: $0.filePath) } +
        posters.map { ImageEndpoint(posterPath: $0.filePath) }
    }
}

extension PosterResponse {
    struct Backdrop: Codable {
        let aspectRatio: Double
        let height: Int
        let iso639_1: String?
        let filePath: String
        let voteAverage: Double
        let voteCount, width: Int
        
        enum CodingKeys: String, CodingKey {
            case aspectRatio = "aspect_ratio"
            case height
            case iso639_1 = "iso_639_1"
            case filePath = "file_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case width
        }
    }
}

extension PosterResponse.Backdrop {
    var imageEndpoint: ImageEndpoint {
        ImageEndpoint(posterPath: filePath)
    }
}

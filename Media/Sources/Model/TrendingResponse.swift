//
//  Trending.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

struct TrendingResponse: Codable {
    let page: Int
    let results: [Trending]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension TrendingResponse {
    struct Trending: Codable {
        let backdropPath: String
        let id: Int
        let originalTitle: String?
        let overview, posterPath: String
        let mediaType: MediaType
        let adult: Bool
        let title: String?
        let originalLanguage: OriginalLanguage
        let genreIDS: [Int]
        let popularity: Double
        let releaseDate: String?
        let video: Bool?
        let voteAverage: Double
        let voteCount: Int
        let originalName, name, firstAirDate: String?
        let originCountry: [String]?
        
        var genreID: Int? {
            if let genreId = genreIDS.first {
                return genreId
            } else {
                return nil
            }
        }
        
        var visibleDate: String? {
            releaseDate?.formatted(
                input: .trendingItemInput,
                output: .trendingItemOutput
            )
        }
        
        var grade: String {
            String(
                format: "%.2f",
                voteAverage
            )
        }
        
        var imageEndpoint: ImageEndpoint {
            ImageEndpoint(posterPath: posterPath)
        }
        
        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case id
            case originalTitle = "original_title"
            case overview
            case posterPath = "poster_path"
            case mediaType = "media_type"
            case adult, title
            case originalLanguage = "original_language"
            case genreIDS = "genre_ids"
            case popularity
            case releaseDate = "release_date"
            case video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case originalName = "original_name"
            case name
            case firstAirDate = "first_air_date"
            case originCountry = "origin_country"
        }
    }
    
    enum MediaType: String, Codable {
        case movie, tv
    }
    
    enum OriginalLanguage: String, Codable {
        case en, fr, ja, zh
    }
}

#if DEBUG
extension TrendingResponse {
    static var mockData: Self? {
        if let url = Bundle.main.url(forResource: "Trending", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let response = try? JSONDecoder().decode(Self.self, from: data)
        {
            return response
        } else {
            return nil
        }
    }
}
#endif

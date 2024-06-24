//
//  String+.swift
//  Media
//
//  Created by gnksbm on 6/24/24.
//

import Foundation

extension String {
    static var tmdbAPIKey: String {
        guard let apiKey = Bundle.main.object(
            forInfoDictionaryKey: "TMDB_API_KEY"
        ) as? String else { fatalError("TMDB_API_KEY 찾을 수 없음") }
        return apiKey
    }
}

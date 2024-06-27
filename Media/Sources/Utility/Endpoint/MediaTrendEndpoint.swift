//
//  MediaTrendEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

// https://api.themoviedb.org/3/trending/all/{time_window}

struct MediaTrendEndpoint: TMDBEndpoint {
    let request: MediaTrendRequest
    
    var path: String {
        "/trending/\(request.trendType.rawValue)/\(request.timeWindow.rawValue)"
    }
    var queries: [String: String]? { .tmdbAPIKey }
}

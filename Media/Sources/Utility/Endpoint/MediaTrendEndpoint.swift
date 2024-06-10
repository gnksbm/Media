//
//  MediaTrendEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

// https://api.themoviedb.org/3/trending/all/{time_window}

struct MediaTrendEndpoint: TMDBEndpoint {
    var trendType: MediaType
    var timeWindow: TimeWindow
    var httpMethod: HTTPMethod { .get }
    
    var path: String {
        "/3/trending/\(trendType.rawValue)/\(timeWindow.rawValue)"
    }
    var queries: [String: String]? { ["api_key": APIKey.mediaTrend] }
    
    init(
        trendType: MediaType,
        timeWindow: TimeWindow = .day
    ) {
        self.trendType = trendType
        self.timeWindow = timeWindow
    }
}

extension MediaTrendEndpoint { 
    enum MediaType: String, CaseIterable {
        case all, movie, tv, person
    }
    
    enum TimeWindow: String {
        case day, week
    }
}

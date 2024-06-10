//
//  MediaTrendEndpoint.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation
// https://api.themoviedb.org/3/trending/all/{time_window}

struct MediaTrendEndpoint: HTTPSEndpointRepresentable {
    var trendType: TrendType
    var timeWindow: TimeWindow
    var httpMethod: HTTPMethod { .get }
    var host: String { "api.themoviedb.org" }
    var path: String {
        "/3/trending/\(trendType.rawValue)/\(timeWindow.rawValue)"
    }
    var queries: [String: String]? { ["api_key": APIKey.mediaTrend] }
    
    init(
        trendType: TrendType,
        timeWindow: TimeWindow = .day
    ) {
        self.trendType = trendType
        self.timeWindow = timeWindow
    }
}

extension MediaTrendEndpoint { 
    enum TrendType: String, CaseIterable {
        case all, movie, tv, person
    }
    
    enum TimeWindow: String {
        case day, week
    }
}

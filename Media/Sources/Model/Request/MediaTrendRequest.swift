//
//  MediaTrendRequest.swift
//  Media
//
//  Created by gnksbm on 6/27/24.
//

import Foundation

struct MediaTrendRequest {
    let trendType: MediaType
    let timeWindow: TimeWindow
    
    init(
        trendType: MediaType,
        timeWindow: TimeWindow = .day
    ) {
        self.trendType = trendType
        self.timeWindow = timeWindow
    }
}

extension MediaTrendRequest {
    enum MediaType: String, CaseIterable {
        case all, movie, tv, person
    }
    
    enum TimeWindow: String {
        case day, week
    }
}
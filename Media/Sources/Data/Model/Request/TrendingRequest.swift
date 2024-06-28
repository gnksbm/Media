//
//  MediaTrendRequest.swift
//  Media
//
//  Created by gnksbm on 6/27/24.
//

import Foundation

struct TrendingRequest {
    let trendType: MediaType
    let timeWindow: TimeWindow
    
    init(
        mediaType: MediaType,
        timeWindow: TimeWindow = .day
    ) {
        self.trendType = mediaType
        self.timeWindow = timeWindow
    }
}

extension TrendingRequest {
    enum MediaType: String, CaseIterable {
        case all, movie, tv, person
        
        var title: String {
            switch self {
            case .all:
                "전체보기"
            case .movie:
                "영화"
            case .tv:
                "TV"
            case .person:
                "사람"
            }
        }
    }
    
    enum TimeWindow: String {
        case day, week
    }
}

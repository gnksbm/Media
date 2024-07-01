//
//  VideoEndpoint.swift
//  Media
//
//  Created by gnksbm on 7/1/24.
//

import Foundation

struct VideoEndpoint: TMDBEndpoint {
    let request: VideoRequest
    
    var path: String {
        "/\(request.mediaType.rawValue)/\(request.seriesID)/videos"
    }
    var queries: [String : String]? { .tmdbAPIKey }
}

//
//  YouTubeEndpoint.swift
//  Media
//
//  Created by gnksbm on 7/1/24.
//

import Foundation

protocol YouTubeEndpoint: HTTPSEndpointRepresentable { }

extension YouTubeEndpoint {
    var host: String { "www.youtube.com" }
}

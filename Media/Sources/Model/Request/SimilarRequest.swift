//
//  SimilarRequest.swift
//  Media
//
//  Created by gnksbm on 6/27/24.
//

import Foundation

struct SimilarRequest {
    let movieID: Int
    let language: String
    let page: Int
    
    init(
        movieID: Int,
        language: String = "en-US",
        page: Int = 1
    ) {
        self.movieID = movieID
        self.language = language
        self.page = page
    }
}

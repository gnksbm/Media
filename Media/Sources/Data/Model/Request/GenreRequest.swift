//
//  GenreRequest.swift
//  Media
//
//  Created by gnksbm on 6/27/24.
//

import Foundation

struct GenreRequest {
    let language: String
    
    init(language: String = "ko") {
        self.language = language
    }
}

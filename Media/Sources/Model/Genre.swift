//
//  Genre.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

struct GenreResponse: Codable {
    let genres: [Genre]
    
    var toDic: [Int: String] {
        Dictionary(uniqueKeysWithValues: genres.map { ($0.id, $0.name) })
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

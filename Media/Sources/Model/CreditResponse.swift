//
//  Credit.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

struct CreditResponse: Codable {
    let id: Int
    let cast, crew: [Cast]
}

extension CreditResponse {
    struct Cast: Codable {
        let adult: Bool
        let gender, id: Int
        let knownForDepartment: Department
        let name, originalName: String
        let popularity: Double
        let profilePath: String?
        let castID: Int?
        let character: String?
        let creditID: String
        let order: Int?
        let department: Department?
        let job: String?
        
        var description: String {
            "\(name) / \"\(character ?? "")\""
        }
        
        var imageEndpoint: ImageEndpoint {
            ImageEndpoint(posterPath: profilePath ?? "")
        }
        
        enum CodingKeys: String, CodingKey {
            case adult, gender, id
            case knownForDepartment = "known_for_department"
            case name
            case originalName = "original_name"
            case popularity
            case profilePath = "profile_path"
            case castID = "cast_id"
            case character
            case creditID = "credit_id"
            case order, department, job
        }
    }
    
    enum Department: String, Codable {
        case acting = "Acting"
        case art = "Art"
        case camera = "Camera"
        case costumeMakeUp = "Costume & Make-Up"
        case crew = "Crew"
        case directing = "Directing"
        case editing = "Editing"
        case lighting = "Lighting"
        case production = "Production"
        case sound = "Sound"
        case visualEffects = "Visual Effects"
        case writing = "Writing"
    }
}

#if DEBUG
extension CreditResponse {
    static var mockData: Self? {
        if let url = Bundle.main.url(forResource: "Credit", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let response = try? JSONDecoder().decode(Self.self, from: data)
        {
            return response
        } else {
            return nil
        }
    }
}
#endif

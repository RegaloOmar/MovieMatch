//
//  MovieResponse.swift
//  MovieMatch
//
//  Created by Omar Regalado Mendoza on 16/07/25.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

//MARK: - Single movie object
struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }
}

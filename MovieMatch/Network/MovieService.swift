//
//  MovieService.swift
//  MovieMatch
//
//  Created by Omar Regalado Mendoza on 16/07/25.
//

import Foundation

class MovieService {
    
    // Find the API Key you saved earlier and paste it here
    private let apiKey = Secrets.tmdbApiKey
    private let baseUrl = "https://api.themoviedb.org/3"

    func fetchPopularMovies() async throws -> [Movie] {
        
        let urlString = "\(baseUrl)/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let movieResponse = try decoder.decode(MovieResponse.self, from: data)
        
        return movieResponse.results
    }
}

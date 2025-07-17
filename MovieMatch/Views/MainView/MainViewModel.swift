//
//  MainViewModel.swift
//  MovieMatch
//
//  Created by Omar Regalado Mendoza on 16/07/25.
//

import Foundation

@MainActor
class MainViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    private let movieService = MovieService()
    
    func loadPopularMovies() async {
        do {
            self.movies = try await movieService.fetchPopularMovies()
        } catch {
            print("Error loading movies: \(error)")
        }
    }
}

//
//  MoviesListViewModel.swift
//  YassirMovies
//
//  Created by Adam Essam on 02/04/2023.
//

import SwiftUI

final class MoviesListViewModel: ObservableObject {
    
    @Published var topRatedMovies: [MovieData] = []
    @Published var upcomingMovies: [MovieData] = []
    @Published var popularMovies: [MovieData] = []
    
    private var networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchMovies() async {
        do {
            let topRatedMovies = try await networkManager.fetchMovies(endpoint: "top_rated")
            let upcomingMovies = try await networkManager.fetchMovies(endpoint: "upcoming")
            let popularMovies = try await networkManager.fetchMovies(endpoint: "popular")
            
            DispatchQueue.main.async {
                self.topRatedMovies = topRatedMovies
                self.upcomingMovies = upcomingMovies
                self.popularMovies = popularMovies
            }
        } catch {
            print("Error fetching movies:", error)
        }
    }
    
    
}

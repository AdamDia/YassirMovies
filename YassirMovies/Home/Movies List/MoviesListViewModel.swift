//
//  MoviesListViewModel.swift
//  YassirMovies
//
//  Created by Adam Essam on 02/04/2023.
//

import SwiftUI

@MainActor
final class MoviesListViewModel: ObservableObject {
//    @Published private(set) var topRatedMovies: [MovieData] = []
     var topRatedMovies: [MovieData] = mockMovieData
    @Published private(set) var upcomingMovies: [MovieData] = []
    @Published private(set) var popularMovies: [MovieData] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false
    
    @Published private(set) var trendingMovies: [MovieData] = []
    @Published private(set) var trailerResult: [TrailerResult] = []
    
    private lazy var movieCategoryDict: [Category: [MovieData]] = [:]
    private let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    private let youtubeTrailerBaseUrl = "https://www.youtube.com/watch?v="
    private var networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchMovies()  async {
        self.isLoading = true
        defer {
            self.isLoading = false
        }
        do {
            let topRatedMovies = try await networkManager.fetchMovies(endpoint: .topRated)
            let upcomingMovies = try await networkManager.fetchMovies(endpoint: .upcoming)
            let popularMovies = try await networkManager.fetchMovies(endpoint: .popular)
            let trendingMovies = try await networkManager.fetchMovies(endpoint: .trending)
            
            Task {
                self.topRatedMovies = topRatedMovies
                self.upcomingMovies = upcomingMovies
                self.popularMovies = popularMovies
                self.trendingMovies = trendingMovies
                self.movieCategoryDict = self.createCategoryDictionary()
            }
            
        } catch {
            if let apiError = error as? APIError {
                switch apiError {
                case .invalidURL:
                    alertItem = AlertContext.invalidURL
                case .invalidResponse:
                    alertItem = AlertContext.invalidResponse
                case .invalidData:
                    alertItem = AlertContext.invalidData
                }
            } else {
                alertItem = AlertContext.invalidData
            }
        }
    }
    
    func createCategoryDictionary() -> [Category: [MovieData]]{
        return  Dictionary(uniqueKeysWithValues: zip(Category.allCases, [topRatedMovies, popularMovies, upcomingMovies]))
    }
    
    func moviePoster(posterPath: String) -> String {
        return imageBaseUrl + posterPath
    }
    
    func youtubeTrailerLink(key: String) -> URL? {
        guard let url = URL(string: youtubeTrailerBaseUrl + key) else { return nil}
        return url
    }
    
    func fetchMovieTrailer(id: Int) async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            let trailers = try await networkManager.fetchTrailerMovieKey(id: id)
            
            Task {
                self.trailerResult = trailers
            }
        } catch {
            if let apiError = error as? APIError {
                switch apiError {
                case .invalidURL:
                    alertItem = AlertContext.invalidURL
                case .invalidResponse:
                    alertItem = AlertContext.invalidResponse
                case .invalidData:
                    alertItem = AlertContext.invalidData
                }
            } else {
                alertItem = AlertContext.invalidData
            }
            
        }
        
    }
}

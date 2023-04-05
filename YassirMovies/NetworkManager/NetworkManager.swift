//
//  NetworkManager.swift
//  YassirMovies
//
//  Created by Adam Essam on 02/04/2023.
//

import UIKit

enum MovieEndpoint: String {
    case topRated = "/3/movie/top_rated"
    case upcoming = "/3/movie/upcoming"
    case popular = "/3/movie/popular"
    case trending = "/3/discover/movie"
}

protocol NetworkProtocol {
    func fetchMovies(endpoint: MovieEndpoint) async throws -> [MovieData]
    func fetchTrailerMovieKey(id: Int) async throws -> [TrailerResult]
}

final class NetworkManager: NetworkProtocol {
    
    private let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    
    func fetchMovies(endpoint: MovieEndpoint) async throws -> [MovieData] {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        
        switch endpoint {
        case .topRated:
            urlComponents.path = endpoint.rawValue 
        case .upcoming:
            urlComponents.path = endpoint.rawValue
        case .popular:
            urlComponents.path = endpoint.rawValue
        case .trending:
            urlComponents.path = endpoint.rawValue
        }
        
        let queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(MovieDataModel.self, from: data).movies
            
        } catch {
            throw APIError.invalidData
        }
    }
    
    
    func fetchTrailerMovieKey(id: Int) async throws -> [TrailerResult] {
        guard let url = URL(string: "\(baseUrl)\(id)/videos?api_key=\(apiKey)") else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(MovieTrailerDataModel.self, from: data).results

        } catch {
            throw APIError.invalidData
        }
    }
}

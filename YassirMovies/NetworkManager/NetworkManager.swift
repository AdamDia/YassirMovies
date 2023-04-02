//
//  NetworkManager.swift
//  YassirMovies
//
//  Created by Adam Essam on 02/04/2023.
//

import Foundation

protocol NetworkProtocol {
    func fetchMovies(endpoint: String) async throws -> [MovieData]
}

final class NetworkManager: NetworkProtocol {
    
    private let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    func fetchMovies(endpoint: String) async throws -> [MovieData] {
        guard let url = URL(string: "\(baseUrl)/movie/\(endpoint)?api_key=\(apiKey)") else {
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
}

//
//  MockNetworkManager.swift
//  YassirMoviesTests
//
//  Created by Adam Essam on 05/04/2023.
//

import Foundation
@testable import YassirMovies

final class MockNetworkManager: NetworkProtocol, JsonLoader {
   
    var mockMatches = [MovieData]()
    var shouldFail = false
    
    func fetchMovies(endpoint: MovieEndpoint) async throws -> [MovieData] {
        let result = try await loadJSON(filename: "MockMoviesJSON", type: MovieDataModel.self)
        if !shouldFail {
            return result.movies
        } else {
            throw APIError.invalidData
        }
    }
    
    func fetchTrailerMovieKey(id: Int) async throws -> [TrailerResult] {
        let result = try await loadJSON(filename: "TrailerMock", type: MovieTrailerDataModel.self)
        if !shouldFail {
            return result.results
        } else {
            throw APIError.invalidData
        }
    }
}

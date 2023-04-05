//
//  NetworkManagerTests.swift
//  YassirMoviesTests
//
//  Created by Adam Essam on 05/04/2023.
//

import XCTest
@testable import YassirMovies

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

    func testFetchMovies() async throws {
        // Given
        let endpoint = MovieEndpoint.topRated

        // When
        let movies = try await networkManager.fetchMovies(endpoint: endpoint)

        // Then
        XCTAssertGreaterThan(movies.count, 0, "fetchMovies() should return at least one movie")
    }

    func testFetchTrailerMovieKey() async throws {
        // Given
        let movieId = 550 // The movie "Fight Club"

        // When
        let trailers = try await networkManager.fetchTrailerMovieKey(id: movieId)

        // Then
        XCTAssertGreaterThan(trailers.count, 0, "fetchTrailerMovieKey() should return at least one trailer")
    }
}

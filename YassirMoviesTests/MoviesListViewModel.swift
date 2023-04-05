//
//  MoviesListViewModel.swift
//  YassirMoviesTests
//
//  Created by Adam Essam on 05/04/2023.
//

import XCTest
@testable import YassirMovies
import SwiftUI

@MainActor
class MoviesListViewModelTests: XCTestCase {
    
    var mockViewModel: MoviesListViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        mockViewModel = MoviesListViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockViewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
 
    func testFetchMoviesSuccess() async {
        // Given
        // When
        await mockViewModel.fetchMovies()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            XCTAssertEqual(self.mockViewModel.topRatedMovies.count, 4)
            XCTAssertEqual(self.mockViewModel.upcomingMovies.count, 4)
            XCTAssertEqual(self.mockViewModel.popularMovies.count, 4)
            XCTAssertEqual(self.mockViewModel.trendingMovies.count, 4)
        }

    }
    
    func testFetchMoviesFailure() async {
        // Given
        mockNetworkManager.shouldFail = true

        // When
        await mockViewModel.fetchMovies()
        
        // Then
        XCTAssertEqual(mockViewModel.alertItem?.title, Text("Server Error"))
        XCTAssertEqual(mockViewModel.alertItem?.message, Text("The data received from the server was invalid. Please contact support"))
    }
    
    func testFetchMovieTrailerSuccess() async {
        // Given
        // When
        await mockViewModel.fetchMovieTrailer(id: 123)

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            XCTAssertEqual(self.mockViewModel.trailerResult.count, 2)
        }
    }
    
    func testYoutubeTrailerLink() {
        // Given
        let key = "abc123"
        
        // When
        let result = mockViewModel.youtubeTrailerLink(key: key)
        
        // Then
        XCTAssertEqual(result, URL(string: "https://www.youtube.com/watch?v=abc123"))
    }
    
    func testMoviePoster() {
            // Given
            let posterPath = "/abc.jpg"
            
            // When
            let result = mockViewModel.moviePoster(posterPath: posterPath)
            
            // Then
            XCTAssertEqual(result, "https://image.tmdb.org/t/p/w500/abc.jpg")
        }
}

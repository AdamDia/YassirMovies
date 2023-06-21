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
    
    //    func testFetchMoviesSuccess() async {
    //        // Given
    //        // When
    //       await mockViewModel.fetchMovies()
    //
    //        // Then
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
    //            XCTAssertEqual(self.mockViewModel.topRatedMovies.count, 4)
    //            XCTAssertEqual(self.mockViewModel.upcomingMovies.count, 4)
    //            XCTAssertEqual(self.mockViewModel.popularMovies.count, 4)
    //            XCTAssertEqual(self.mockViewModel.trendingMovies.count, 4)
    //        }
    //
    //    }
    func testFetchMoviesSuccess() async {
        // Given
        // Create an expectation for the async task to complete
        let expectation = XCTestExpectation(description: "Movies fetched successfully")
        
        // When
        await mockViewModel.fetchMovies()
        
        // Then
        // Wait for the async task to complete before executing the assertions
        do {
            try await Task.sleep(nanoseconds: 5_000_000_000)  // Wait for 5 seconds
        } catch {
            XCTFail("Failed to sleep: \(error)")
        }
        
        XCTAssertEqual(mockViewModel.topRatedMovies.count, 4)
        XCTAssertEqual(mockViewModel.upcomingMovies.count, 4)
        XCTAssertEqual(mockViewModel.popularMovies.count, 4)
        XCTAssertEqual(mockViewModel.trendingMovies.count, 4)
        
        // Fulfill the expectation to indicate the async task has completed
        expectation.fulfill()
        
        // Wait for the expectation to be fulfilled, with a timeout of 10 seconds
        await XCTWaiter().fulfillment(of: [expectation], timeout: 10)
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
        let expectation = XCTestExpectation(description: "Trailer Fetched Successfully")
        // When
        await mockViewModel.fetchMovieTrailer(id: 123)
        
        // Then
        do {
            try await Task.sleep(nanoseconds: 5_000_000_000)
        } catch {
            XCTFail("Failed to sleep: \(error)")
        }
        
        XCTAssertEqual(self.mockViewModel.trailerResult.count, 2)
        
        expectation.fulfill()
        await XCTWaiter().fulfillment(of: [expectation], timeout: 10)
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

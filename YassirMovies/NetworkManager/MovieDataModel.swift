//
//  MovieDataModel.swift
//  YassirMovies
//
//  Created by Adam Essam on 31/03/2023.
//

import Foundation

struct Movie: Codable, Identifiable {
    var id: Int
    var thumbnail: String
    var title: String
    var description: String
    var trailerLink: String
    var catagory: Catagory
    var isFeaturedMovie: Bool
    
    enum Catagory: String, CaseIterable, Codable {
        case topRated = "Top Rated"
        case popular = "Popular"
        case upComing = "Upcoming"
    }
}


// MARK: - MovieDataModel
struct MovieDataModel: Codable {
    let page: Int
    let movies: [MovieData]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieData
struct MovieData: Codable {
    let id: Int
    let posterPath, title, description: String

    enum CodingKeys: String, CodingKey {
        case id
        case description = "overview"
        case posterPath = "poster_path"
        case title
    }
}


// MARK: - movie trailer video key
struct MovieTrailerDataModel: Codable {
    let id: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let utubeTrailerKey: String
    
    enum CodingKeys: String, CodingKey {
       case utubeTrailerKey = "key"
    }
}

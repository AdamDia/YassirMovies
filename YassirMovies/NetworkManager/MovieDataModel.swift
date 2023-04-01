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
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

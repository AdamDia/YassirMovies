//
//  MovieDataModel.swift
//  YassirMovies
//
//  Created by Adam Essam on 31/03/2023.
//

import Foundation

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
struct MovieData: Codable, Identifiable {
    let id: Int
    let posterPath, title, description: String

    enum CodingKeys: String, CodingKey {
        case id
        case description = "overview"
        case posterPath = "poster_path"
        case title
    }
}


// MARK: - Movie trailer video key
struct MovieTrailerDataModel: Codable {
    let id: Int
    let results: [TrailerResult]
}

// MARK: - Result
struct TrailerResult: Codable {
    let utubeTrailerKey: String
    
    enum CodingKeys: String, CodingKey {
       case utubeTrailerKey = "key"
    }
}

enum Category: String, CaseIterable, Comparable {
    case topRate = "Top Rated"
    case popular = "Popular"
    case upcoming = "Upcoming"
    
    static func < (lhs: Category, rhs: Category) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

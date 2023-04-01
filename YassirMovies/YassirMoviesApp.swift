//
//  YassirMoviesApp.swift
//  YassirMovies
//
//  Created by Adam Essam on 30/03/2023.
//

import SwiftUI

@main
struct YassirMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesListView()
//            MovieDetails(movie: moviesData.first!, showingDetails: false)
//            SeeAllList(categoryName: moviesData.first!.catagory.rawValue, movies: moviesData)
        }
    }
}

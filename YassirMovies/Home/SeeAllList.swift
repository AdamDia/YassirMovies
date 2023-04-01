//
//  SeeAllList.swift
//  YassirMovies
//
//  Created by Adam Essam on 01/04/2023.
//

import SwiftUI

struct SeeAllList: View {
    var categoryName: String
    var movies: [Movie]
    var body: some View {
            List(movies) { movie in
                NavigationLink(destination: MovieDetails(movie: movie)) {
                    SeeAllMovieCell(movie: movie)
                }
                .listRowSeparator(.hidden)
            }
            .navigationTitle(categoryName)
            .listStyle(.plain)
    }
}

struct SeeAllList_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllList(categoryName: moviesData.first!.catagory.rawValue, movies: moviesData)
    }
}

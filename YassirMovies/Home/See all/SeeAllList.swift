//
//  SeeAllList.swift
//  YassirMovies
//
//  Created by Adam Essam on 01/04/2023.
//

import SwiftUI

struct SeeAllList: View {
    var categoryName: String
    var movies: [MovieData]
    @ObservedObject var viewModel: MoviesListViewModel
    
    var body: some View {
        List(movies) { movie in
            NavigationLink(destination: MovieDetails(movie: movie, viewModel: viewModel)) {
                SeeAllMovieCell(movie: movie, viewModel: viewModel)
                }
                .listRowSeparator(.hidden)
            }
            .navigationTitle(categoryName)
            .listStyle(.plain)
    }
}

struct SeeAllList_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllList(categoryName: "Category Name", movies: mockMovieData,
                  viewModel: MoviesListViewModel(networkManager: NetworkManager()))
    }
}

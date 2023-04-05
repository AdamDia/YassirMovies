//
//  MoviePosterView.swift
//  YassirMovies
//
//  Created by Adam Essam on 05/04/2023.
//

import SwiftUI

struct MoviePosterView: View {
    var movie: MovieData
    @ObservedObject var viewModel: MoviesListViewModel

    var body: some View {
        KingFisherImageView(imageStrURL: viewModel.moviePoster(posterPath: movie.posterPath))
            .aspectRatio(contentMode: .fill)
    }
}

//
//  MovieItem.swift
//  YassirMovies
//
//  Created by Adam Essam on 31/03/2023.
//

import SwiftUI

struct MovieItem: View {
    
    @ObservedObject var viewModel: MoviesListViewModel
    var movie: MovieData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            KingFisherImageView(imageStrURL: viewModel.moviePoster(posterPath: movie.posterPath))
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 170)
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 10)
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .foregroundColor(.primary)
                    .font(.headline)
                Text(movie.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(height: 40)
            }
        }
    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieItem(viewModel: MoviesListViewModel(networkManager: NetworkManager()), movie: mockMovieData.first!)
    }
}

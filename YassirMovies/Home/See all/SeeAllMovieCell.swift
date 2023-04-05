//
//  SeeAllMovieCell.swift
//  YassirMovies
//
//  Created by Adam Essam on 01/04/2023.
//

import SwiftUI

struct SeeAllMovieCell: View {
    
    var movie: MovieData
    @ObservedObject var viewModel: MoviesListViewModel
    var body: some View {
        HStack {
            KingFisherImageView(imageStrURL: viewModel.moviePoster(posterPath: movie.posterPath))
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .cornerRadius(20)
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                    .padding(.bottom, 3)
                Text(movie.description)
                    .lineLimit(2)
            }
            
        }
    }
}

struct SeeAllMovieCell_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllMovieCell(movie:  mockMovieData.first! , viewModel: MoviesListViewModel(networkManager: NetworkManager()))
    }
}

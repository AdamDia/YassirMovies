//
//  SeeAllMovieCell.swift
//  YassirMovies
//
//  Created by Adam Essam on 01/04/2023.
//

import SwiftUI

struct SeeAllMovieCell: View {
    var movie: Movie
    var body: some View {
        HStack {
            Image(movie.thumbnail)
                .resizable()
                .scaledToFit()
                .frame(width: 150)
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
        SeeAllMovieCell(movie: moviesData.first!)
    }
}

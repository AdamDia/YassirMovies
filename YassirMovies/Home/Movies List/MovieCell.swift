//
//  MovieCell.swift
//  YassirMovies
//
//  Created by Adam Essam on 31/03/2023.
//

import SwiftUI

struct MovieCell: View {
    var categoryName: String
    var movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(categoryName)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.leading, 5)
                Spacer()
                NavigationLink(destination: SeeAllList(categoryName: categoryName, movies: movies)) {
                    Text("See all")
                        .foregroundColor(.blue)
                }
                .padding()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination:
                                        MovieDetails(movie: movie)) {
                            MovieItem(movie: movie)
                                .frame(width: 300)
                                .padding(.trailing)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding(.leading, 5)
        }
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(categoryName: "Category Name", movies: load("MoviesMock"))
    }
}


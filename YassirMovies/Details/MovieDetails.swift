//
//  MovieDetails.swift
//  YassirMovies
//
//  Created by Adam Essam on 01/04/2023.
//

import SwiftUI

struct MovieDetails: View {
    var movie: Movie
    @State var showingDetails = false
    
    var body: some View {
        VStack() {
            Image(movie.thumbnail)
                .resizable()
                .scaledToFill()
                .frame(height: 225)
            Text(movie.title)
                .font(.title)
                .fontWeight(.bold)
            Text(movie.description)
                .lineSpacing(5.0)
                .padding(5.0)
            Spacer()
            Button(action:  {
                self.showingDetails.toggle()
            }) {
                Text("Watch Trailor")
                    .font(.headline)
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            } .fullScreenCover(isPresented: $showingDetails) {
                TrailorView(movieURL: URL(string: movie.trailerLink)!)
            }
        }
        
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movie: moviesData.first!)
    }
}

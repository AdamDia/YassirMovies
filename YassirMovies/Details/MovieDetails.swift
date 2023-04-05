//
//  MovieDetails.swift
//  YassirMovies
//
//  Created by Adam Essam on 01/04/2023.
//

import SwiftUI

struct MovieDetails: View {
    var movie: MovieData
    @State var showingDetails = false
    @ObservedObject var viewModel: MoviesListViewModel
    private let youtubeTrailerBaseUrl = "https://www.youtube.com/watch?v="
    
    var body: some View {
        ZStack{
            VStack() {
                KingFisherImageView(imageStrURL: viewModel.moviePoster(posterPath: movie.posterPath))
                    .frame(height: 400)
                    .aspectRatio(contentMode: .fill)
                Text(movie.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
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
                    if let trailerKey = viewModel.trailerResult.first?.utubeTrailerKey, let url = viewModel.youtubeTrailerLink(key: trailerKey) {
                        TrailorView(movieURL: url)
                    }
                }
                Spacer()
            }
            .ignoresSafeArea()
            .task {
                await viewModel.fetchMovieTrailer(id: movie.id)
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movie: mockMovieData.first!, viewModel: MoviesListViewModel(networkManager: NetworkManager()))
    }
}

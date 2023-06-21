//
//  MoviesListView.swift
//  YassirMovies
//
//  Created by Adam Essam on 30/03/2023.
//

import SwiftUI

struct MoviesListView: View {
    
    @StateObject var viewModel: MoviesListViewModel = MoviesListViewModel(networkManager: NetworkManager())
    
    var movieCategories: [Category: [MovieData]] {
        viewModel.createCategoryDictionary()
    }
    
    var body: some View {
        ZStack{
            NavigationView {
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        TabView {
                            ForEach(viewModel.trendingMovies) { movie in
                                MoviePosterView(movie: movie, viewModel: viewModel)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(height: 225)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        
                        Spacer()
                        
                        VStack {
                            ForEach(movieCategories.keys.sorted(), id: \.self) {
                                key in
                                MovieCell(categoryName: key.rawValue, movies: movieCategories[key]!, viewModel: viewModel)
                                    .frame(height: 300)
                                    .padding(.top)
                                    .padding(.bottom)
                            }
                        }
                    }
                    .navigationTitle("Movies")
                }
            }
            .task {
                await viewModel.fetchMovies()
            }
            if viewModel.isLoading {LoadingView()}
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}

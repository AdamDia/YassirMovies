//
//  MoviesListView.swift
//  YassirMovies
//
//  Created by Adam Essam on 30/03/2023.
//

import SwiftUI

struct MoviesListView: View {
    
    var catagories: [String: [Movie]] {
        .init(grouping: moviesData,
              by: {$0.catagory.rawValue}
        )
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    TabView {
                        ForEach(moviesData) { movie in
                            Image(movie.thumbnail)
                                .resizable()
                                .scaledToFill()
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 225)
                    
                    Spacer()
                    
                    VStack {
                        ForEach(catagories.keys.sorted(), id: \String.self) {
                            key in
                            MovieCell(categoryName: key, movies: catagories[key]!)
                                .frame(height: 300)
                                .padding(.top)
                                .padding(.bottom)
                        }
                    }
                }
                .navigationTitle("Movies")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}

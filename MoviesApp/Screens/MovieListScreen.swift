//
//  MovieListScreen.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-10.
//

import SwiftUI
import SwiftData

struct MovieListScreen: View {
    
    // fetch all the movies
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @State private var isAddMoviePresented: Bool = false
    
    var body: some View {
        MovieListView(movies: movies)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie") {
                    isAddMoviePresented = true
                }
            }
        })
        .sheet(isPresented: $isAddMoviePresented, content: {
            NavigationStack {
                AddMovieScreen()
            }
        })
    }
}

#Preview {
    MovieListScreen()
        .modelContainer(for: [Movie.self])
}

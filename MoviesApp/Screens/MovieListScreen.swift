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
    @Query private var movies: [Movie]
    
    var body: some View {
        List(movies) { movie in
            Text(movie.title)
        }
    }
}

#Preview {
    MovieListScreen()
        .modelContainer(for: [Movie.self])
}

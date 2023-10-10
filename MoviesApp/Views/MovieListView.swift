//
//  MovieListView.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-10.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
    
    let movies: [Movie]
    // need environment variable to access model context
    @Environment(\.modelContext) private var context
    
    private func deleteMovie(indexSet: IndexSet) {
        indexSet.forEach { index in
            let movie = movies[index]
            // context.delete will delete but...
            context.delete(movie)
            do {
                // explicitly save is better
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        List {
            // Foreach include .onDelete
            ForEach(movies) { movie in
                HStack {
                    Text(movie.title)
                    Spacer()
                    // string description of Int
                    Text(movie.year.description)
                }
            }.onDelete(perform: deleteMovie)
        }
    }
}

#Preview {
    // pass in empty movie array
    // set up modelContainer for the movie type
    MovieListView(movies: [])
        .modelContainer(for: [Movie.self])
}

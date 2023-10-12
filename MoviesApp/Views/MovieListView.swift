//
//  MovieListView.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-10.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
    
    @Query private var movies: [Movie]
    let filterOption: FilterOption
    
    init(filterOption: FilterOption = .none) {
        self.filterOption = filterOption
        switch self.filterOption {
        case .title(let movieTitle):
            _movies = Query(filter: #Predicate { $0.title.contains(movieTitle)})
        case .none:
            _movies = Query()
        }
    }
    
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
                // value movie is Hashable
                NavigationLink(value: movie) {
                    // HStack here is Nav Link's "label:"
                    HStack {
                        Text(movie.title)
                        Spacer()
                        // string description of Int
                        Text(movie.year.description)
                    }
                }
            }.onDelete(perform: deleteMovie)
            // nav woks because "value: movie" above and this "for: Movie.self" Types match
        }.navigationDestination(for: Movie.self) { movie in
            MovieDetailScreen(movie: movie)
        }
    }
}

#Preview {
    // pass in empty movie array
    // set up modelContainer for the movie type
    MovieListView(filterOption: .none)
        .modelContainer(for: [Movie.self])
}

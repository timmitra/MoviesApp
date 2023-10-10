//
//  MovieListScreen.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-10.
//

import SwiftUI
import SwiftData

struct MovieListScreen: View {
    
    @Environment(\.modelContext) var modelContext
    // fetch all the movies
    @Query private var movies: [Movie]
    
    var body: some View {
        NavigationStack {
            List(movies) { movie in
                Text(movie.title)
            }
        }
        .toolbar {
            Button("Add Movies", action: addSamples)
        }
    }
    
    func addSamples() {
        let batman = Movie(title: "Bat Man", year: 1998)
        let oppy = Movie(title: "Oppenheimer", year: 2023)
        let starwars = Movie(title: "Star Wars", year: 1977)
        
        modelContext.insert(batman)
        modelContext.insert(oppy)
        modelContext.insert(starwars)
    }
}

#Preview {
    MovieListScreen()
        .modelContainer(for: [Movie.self])
}

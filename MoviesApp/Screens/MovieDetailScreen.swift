//
//  MovieDetailScreen.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-10.
//

import SwiftUI
import SwiftData

struct MovieDetailScreen: View {
    
    @Environment(\.modelContext) private var context
    let movie: Movie
    
    @State private var title: String = ""
    @State private var year: Int?
    
    var body: some View {
        Form {
            TextField("title", text: $title)
            TextField("year", value: $year, format: .number)
        }.onAppear {
            title = movie.title
            year = movie.year
        }
    }
}

// this struct is for the PreviewProvider
struct MovieDetailContainerScreen: View {
    
    @Environment(\.modelContext) private var context
    @State private var movie:  Movie?
    
    var body: some View {
        ZStack {
            if let movie {
                MovieDetailScreen(movie: movie)
            }
        }
        .onAppear {
            movie = Movie(title: "Spiderman", year: 2023)
            context.insert(movie!)
        }
    }
}

#Preview {
    MovieDetailContainerScreen()
        .modelContainer(for: [Movie.self])
}

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
    @State private var showReviewScreen: Bool = false
    
    var body: some View {
        Form {
            TextField("title", text: $title)
            TextField("year", value: $year, format: .number)
            Button("Update") {
                // guard that the year is unwrapped
                guard let year = year else { return }
                
                movie.title = title
                movie.year = year
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }.buttonStyle(.borderless) // no highlighting
            
            Section("Reviews") {
                Button(action: {
                    showReviewScreen = true
                }, label: {
                    Image(systemName: "plus")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                if let reviews = movie.reviews {
                    if reviews.isEmpty {
                        ContentUnavailableView {
                            Text("No reviews")
                        }
                    } else {
                        ReviewListView(reviews: reviews)
                    }
                }
            }
            
        }.onAppear {
            title = movie.title
            year = movie.year
        }
        .sheet(isPresented: $showReviewScreen, content: {
            NavigationStack {
                AddReviewScreen(movie: movie) // passing in the movie
            }
        })
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

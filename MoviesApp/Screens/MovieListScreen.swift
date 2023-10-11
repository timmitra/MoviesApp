//
//  MovieListScreen.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-10.
//

import SwiftUI
import SwiftData

struct MovieListScreen: View {
    
    @Environment(\.modelContext) private var context
    // fetch all the movies
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]

    @State private var isAddMoviePresented: Bool = false
    @State private var isActorPresented: Bool = false
    @State private var actorName: String = ""
    
    private func saveActor() {
        let actor = Actor(name: actorName)
        context.insert(actor)
    }

    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Movies")
                .font(.largeTitle)
            MovieListView(movies: movies)
            Text("Actors")
                .font(.largeTitle)
            ActorListView(actors: actors)
        }
        .padding()
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button("Add Actor") {
                    isActorPresented = true
                }
            }
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
        .sheet(isPresented: $isActorPresented, content: {
            Text("Add Actor")
                .font(.largeTitle)
            TextField("Actor Name", text: $actorName)
                .textFieldStyle(.roundedBorder)
                .presentationDetents([.fraction(0.25)])
                .padding()
            Button("Save") {
                isActorPresented = false
                saveActor()
                actorName = ""
            }
        })
    }
}

#Preview {
    MovieListScreen()
        .modelContainer(for: [Movie.self, Review.self, Actor.self])
}

//
//  ActorDetailScreen.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-11.
//

import SwiftUI

struct ActorDetailScreen: View {
    
    @Environment(\.modelContext) private var context
    
    let actor: Actor
    @State private var selectedMovies: Set<Movie> = []
    
    var body: some View {
        VStack {
            MovieSelectionView(selectedMovie: $selectedMovies)
                .onAppear{
                    selectedMovies = Set(actor.movies) // convert Array to a Set
                }
        }.onChange(of: selectedMovies, {
            actor.movies = Array(selectedMovies)
            context.insert(actor)
        })
            .navigationTitle(actor.name)
    }
}

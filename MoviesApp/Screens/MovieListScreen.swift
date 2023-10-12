//
//  MovieListScreen.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-10.
//

import SwiftUI
import SwiftData

enum Sheets: Identifiable {
    case addMovie
    case addActor
    case showFilter
    
    var id: Int {
        hashValue
    }
}

struct MovieListScreen: View {
    
    @Environment(\.modelContext) private var context
    // fetch all the movies
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]

    @State private var actorName: String = ""
    @State private var activeSheet: Sheets?
    
    @State var filterOption: FilterOption = .none
    
    private func saveActor() {
        let actor = Actor(name: actorName)
        context.insert(actor)
    }

    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("Movies")
                    .font(.largeTitle)
                Spacer()
                Button("Filter") {
                    activeSheet = .showFilter
                }
            }
            MovieListView(filterOption: filterOption)
            Text("Actors")
                .font(.largeTitle)
            ActorListView(actors: actors)
        }
        .padding()
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button("Add Actor") {
                    activeSheet = .addActor
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie") {
                    activeSheet = .addMovie
                }
            }
        })
        .sheet(item: $activeSheet, content: { activeSheet in
            switch activeSheet {
            case .addMovie:
                NavigationStack {
                    AddMovieScreen()
                }
            case .addActor:
                Text("Add Actor")
                    .font(.largeTitle)
                TextField("Actor Name", text: $actorName)
                    .textFieldStyle(.roundedBorder)
                    .presentationDetents([.fraction(0.25)])
                    .padding()
                Button("Save") {
                    saveActor()
                    actorName = ""
                    self.activeSheet = nil // dismiss the sheet
                }
            case .showFilter:
                FilterSelectionScreen(filterOption: $filterOption)
            }
        })
    }
}

#Preview {
    MovieListScreen()
        .modelContainer(for: [Movie.self, Review.self, Actor.self])
}

//
//  AddMovieScreen.swift
//  Movies
//
//  Created by Mohammad Azam on 6/6/23.
//

import SwiftUI
import SwiftData

struct AddMovieScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var year: Int?
    @State private var selectedActors: Set<Actor> = []

    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace && year != nil && !selectedActors.isEmpty
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
            
            Section("Select Actors") {
                ActorSelectionView(selectActors: $selectedActors)
            }
        }
        // quick way to check if actors are added when selected
        .onChange(of: selectedActors, {
            print(selectedActors.count)
        })
        .navigationTitle("Add Movie")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    
                    guard let year = year else { return }
                    
                    let movie = Movie(title: title, year: year)
                    movie.actors = Array(selectedActors) // convert Set to Array
                    
                    // for each actor selected add them to balance both sides
                    selectedActors.forEach { actor in
                        actor.movies.append(movie)
                        context.insert(actor)
                    }
                    
                    context.insert(movie)
                    
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    // dismiss the modal
                    dismiss()
                    
                }.disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddMovieScreen()
            .modelContainer(for: [Movie.self])
    }
}

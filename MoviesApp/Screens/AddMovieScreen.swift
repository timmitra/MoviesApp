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
    
    private var isFormValid: Bool {
       // !title.isEmptyOrWhiteSpace && year != nil
        return false
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
        }
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
                    context.insert(movie)
                    
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
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

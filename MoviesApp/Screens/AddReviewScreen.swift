//
//  AddReviewScreen.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-10.
//

import SwiftUI
import SwiftData

struct AddReviewScreen: View {
    
    let movie: Movie
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var subject: String = ""
    @State private var description: String = ""
    
    // form validation
    private var isFormatValid: Bool {
        !subject.isEmptyOrWhiteSpace && !description.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        Form {
            TextField("subject", text: $subject)
            TextField("description", text: $description)
        }.navigationTitle("Add Review")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        
                        let review = Review(subject: subject, body: description)
                        review.movie = movie // we were passed movie already, so assign it to review
                        context.insert(review) // this will save but we can be explicit
                        do {
                            try context.save()
                            // append the review to the movie
                            movie.reviews.append(review)
                        } catch {
                            print(error.localizedDescription)
                        }
                        dismiss()
                        
                    }.disabled(!isFormatValid)
                }
            }
    }
}

// this struct is for the PreviewProvider
struct MovieReviewContainerScreen: View {
    
    @Environment(\.modelContext) private var context
    @State private var movie:  Movie?
    
    var body: some View {
        ZStack {
            if let movie {
                AddReviewScreen(movie: movie)
                
            }
        }
        .onAppear {
            movie = Movie(title: "Spiderman", year: 2023)
           // subject = "My Awesome Review"
            context.insert(movie!)
        }
    }
}


#Preview {
    MovieReviewContainerScreen()
}

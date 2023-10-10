//
//  ReviewListView.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-10.
//

import SwiftUI

struct ReviewListView: View {
    
    let reviews: [Review]
    
    var body: some View {
        List {
            ForEach(reviews) { review in
                VStack(alignment: .leading) {
                    Text(review.subject)
                    Text(review.body)
                }
            }
        }
    }
}

#Preview {
    ReviewListView(reviews: [])
}

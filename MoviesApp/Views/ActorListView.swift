//
//  ActorListView.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-11.
//

import SwiftUI

struct ActorListView: View {
    
    let actors: [Actor]
    
    var body: some View {
        List(actors) { actor in
            Text(actor.name)
        }
    }
}

#Preview {
    ActorListView(actors: [])
}

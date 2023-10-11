//
//  ActorSelectionView.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-11.
//

import SwiftUI
import SwiftData

struct ActorSelectionView: View {
    
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    @Binding var selectActors: Set<Actor>
    
    var body: some View {
        List(actors) { actor in
            HStack {
                Image(systemName: selectActors.contains(actor) ? "checkmark.square" : "square")
                    .onTapGesture {
                        if !selectActors.contains(actor) {
                            selectActors.insert(actor)
                        } else {
                            selectActors.remove(actor)
                        }
                    }
                Text(actor.name)
            }
        }
    }
}

//#Preview {
//    ActorSelectionView()
//}

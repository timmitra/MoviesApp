//
//  ActorCellView.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-11.
//

import SwiftUI

struct ActorCellView: View {
    
    let actor: Actor
    
    var body: some View {
        VStack {
            Text(actor.name)
            Text(actor.movies.map { $0.title }, format: .list(type:.and))
                .font(.caption)
        }
    }
}

//#Preview {
//    ActorCellView()
//}

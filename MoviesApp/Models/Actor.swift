//
//  Actor.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-10.
//

import Foundation
import SwiftData

@Model
final class Actor {
    
    var name: String
    var movies: [Movie] = []
    
    init(name: String) {
        self.name = name
    }
}

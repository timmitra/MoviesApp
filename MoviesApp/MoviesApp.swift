//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-10.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListScreen()
            }
            ContentView()
        }.modelContainer(for: [Movie.self])
    }
}

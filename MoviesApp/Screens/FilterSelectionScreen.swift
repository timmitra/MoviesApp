//
//  FilterSelectionScreen.swift
//  MoviesApp
//
//  Created by Tim Mitra on 2023-10-11.
//

import SwiftUI

enum FilterOption {
    case title(String)
    case none
}

struct FilterSelectionScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var movieTitle: String = ""
    @Binding var filterOption: FilterOption
    
    var body: some View {
        Form {
            Section("Filer by title") {
                TextField("Movie Title", text: $movieTitle)
                Button("Search") {
                    filterOption = .title(movieTitle)
                    dismiss()
                }
            }
        }
    }
}

//#Preview {
//    FilterSelectionScreen()
//}

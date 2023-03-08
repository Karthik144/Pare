//
//  SerachBarView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct SearchBar: View {

    // MARK: - PROPERTIES
    @State private var searchText = ""
    let customColor = Color("D5D3D3")

    // MARK: - BODY
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")

            TextField("Where to shop?", text: $searchText)
        }
        .font(.headline)
        .padding()
        .overlay(
            Capsule(style: .continuous)
                .stroke(Color.gray, lineWidth: 1)
        )

        .padding()
    }
}


// MARK: - PREVIEW
struct SerachBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}

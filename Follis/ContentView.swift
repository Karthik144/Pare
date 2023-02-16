//
//  ContentView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import SwiftUI

struct ContentView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel

    // MARK: - BODY
    var body: some View {


        Button(action: {
            // Sign user out
            viewModel.signOut()
        }, label: {
            Label("Sign Out", systemImage: "person.crop.circle.fill.badge.minus")
                .foregroundColor(.red)
        })

    }
}


// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  Benefit1View.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/27/23.
//

import SwiftUI

struct Benefit1View: View {

    // MARK: - PROPERTIES

    // MARK: - BODY
    var body: some View {

        VStack{


            // Header
            Text("Welcome to Pare")
                .font(.title)
                .fontWeight(.bold)

            // Benefit + Message
            VStack(spacing: 3){

                Text("BENEFIT #1")
                    .font(.title3)
                    .foregroundColor(Color.accentColor)
                    .fontWeight(.bold)

                Text("Earn 10% cash back on each order")
                    .font(.title)
                    .fontWeight(.light)
            } //: VSTACK


            // Image


            // Buttons 








        } //: VSTACK

    } //: VIEW
}


// MARK: - PREVIEW 
struct Benefit1View_Previews: PreviewProvider {
    static var previews: some View {
        Benefit1View()
    }
}

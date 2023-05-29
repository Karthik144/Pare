//
//  LearnMoreView.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/28/23.
//

import SwiftUI

struct LearnMoreView: View {

    // MARK: - PROPERTIES

    // MARK: - BODY
    var body: some View {


        VStack(alignment: .leading, spacing: 20){

            // Title & Body #1
            VStack(alignment: .leading, spacing: 5){
                Text("What's a wallet?")
                    .fontWeight(.bold)
                    .font(.title3)

                Text("Think of it as a username. Anyone can send you money if they have this.")
                    .fontWeight(.light)
                
            } //: VSTACK

            // Title & Body #2
            VStack(alignment: .leading, spacing: 5){
                Text("What’s USDC?")
                    .fontWeight(.bold)
                    .font(.title3)

                Text("Think of it as a username. Anyone can send you money if they have this. ")
                    .fontWeight(.light)

            } //: VSTACK

            // Title & Body #3
            VStack(alignment: .leading, spacing: 5){
                Text("Want to learn more? ")
                    .fontWeight(.bold)
                    .font(.title3)

                Text("Hop on a call with us, and we’ll answer any questions you have!")
                    .fontWeight(.light)

            } //: VSTACK


            Button(action: {
                // Add link to calendly

            }) {

                HStack{

                    Text("Schedule a call with us")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)


                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.white)


                } //: HSTACK
                .background(
                    RoundedRectangle(cornerRadius: 8,  style: .continuous)
                        .fill(Color.accentColor)
                        .frame(width: 250, height: 45)
                )


            } //: BUTTON
            .padding()

            Spacer()


        } //: VSTACK
        .padding()
        .navigationTitle("Learn More")
        .navigationBarTitleDisplayMode(.inline)


    } //: BODY

} //: VIEW


// MARK: - PREVIEW
struct LearnMoreView_Previews: PreviewProvider {
    static var previews: some View {
        LearnMoreView()
    }
}

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


        VStack(alignment: .leading, spacing: 30){

            // Title & Body #1
            VStack(alignment: .leading, spacing: 5){
                Text("What's a wallet?")
                    .fontWeight(.bold)
                    .font(.title3)

                Text("A replica of your physical wallet, but digital. Only you control spending & access, no 3rd-party banks involved.")
                    .fontWeight(.light)
                
            } //: VSTACK

            // Title & Body #2
            VStack(alignment: .leading, spacing: 5){
                Text("What’s USD?")
                    .fontWeight(.bold)
                    .font(.title3)

                Text("Digital cash on the internet with no limitations on borders, speed, or access.")
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
                guard let url = URL(string: "https://calendly.com/getparehelp/30min") else { return }
                            
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }

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
        .navigationBarTitleDisplayMode(.large)


    } //: BODY

} //: VIEW


// MARK: - PREVIEW
struct LearnMoreView_Previews: PreviewProvider {
    static var previews: some View {
        LearnMoreView()
    }
}

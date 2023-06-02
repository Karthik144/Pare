//
//  FirstStoryView.swift
//  Pare
//
//  Created by Karthik  Ramu on 6/2/23.
//

import SwiftUI

struct FirstStoryView: View {

    // MARK: - PROPERTIES
    let customColor = Color(red: 43/255, green: 74/255, blue: 238/255)


    // MARK: - BODY
    var body: some View {

        VStack(alignment: .leading){

            // Main message
            Group{
                Text("Every time you pay at a shop, ")
                    .font(.title.weight(.bold))

                +

                Text("**middlemen**")
                    .foregroundColor(Color.accentColor)
                    .font(.title.weight(.bold))

                +
                Text(" take a cut")
                    .font(.title.weight(.bold))
            }
            .padding()
            .padding(.bottom, 0)

            Spacer()
            // Sub message
            Text("Merchants have to pay....")
                .font(.title2.weight(.bold))
                .padding()

            // Costs
            VStack(alignment: .leading, spacing: 15){

                // Cost #1
                Group{

                    Text("**~4%** ")
                        .font(.title3)
                        .foregroundColor(Color.accentColor)

                    +

                    Text("when you use a credit card")
                        .font(.title3)

                } // GROUP
                .padding(.leading)

                // Cost #2
                Group{

                    Text("**~30%** ")
                        .font(.title3)
                        .foregroundColor(Color.accentColor)

                    +

                    Text("when you order via pickup apps")
                        .font(.title3)

                } //: GROUP
                .padding(.leading)



            } //: VSTACK
            .padding()


            Spacer()



            // Graphic
            Image("payment_flow")
                .resizable()
                .scaledToFit()
                .frame(width: 282, height: 290)
                .padding()
                .padding(.leading, 0)


            Spacer()


            HStack{

                Spacer()

                // Show ThirdStoryView
                NavigationLink {
                    ThirdStoryView()
                } label: {

                    Text("Next")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(customColor)
                                .frame(width: 300, height: 50)
                        )

                } //: BUTTON
                .padding(.bottom, 35)

                Spacer()


            } //: HSTACK




        } //: VSTACK
        .navigationTitle("Add Funds")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - PREVIEW
struct FirstStoryView_Previews: PreviewProvider {
    static var previews: some View {
        FirstStoryView()
    }
}

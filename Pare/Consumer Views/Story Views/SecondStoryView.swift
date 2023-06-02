//
//  SecondStoryView.swift
//  Pare
//
//  Created by Karthik  Ramu on 6/2/23.
//

import SwiftUI

struct SecondStoryView: View {

    // MARK: - PROPERTIES
    let customColor = Color(red: 43/255, green: 74/255, blue: 238/255)


    // MARK: - BODY
    var body: some View {

        VStack(alignment: .leading){

            // Main message
            Group{
                Text("Merchants put this burden on ")
                    .font(.title.weight(.bold))

                +

                Text("**you**")
                    .foregroundColor(Color.accentColor)
                    .font(.title.weight(.bold))
            }
            .padding()
            .padding(.bottom, 0)

            // Main message
            Group{
                Text("So you pay ")
                    .font(.title.weight(.bold))

                +

                Text("**higher** ")
                    .foregroundColor(Color.accentColor)
                    .font(.title.weight(.bold))

                +

                Text("prices")
                    .font(.title.weight(.bold))
            }
            .padding()
            .padding(.bottom, 0)

            Spacer()

            HStack{

                Spacer()

                // Image
                Image("high_price")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 283, height: 293)
                    .padding()

                Spacer()


            } //: HSTACK

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

    } // VIEW
}


// MARK: - PREVIEW
struct SecondStoryView_Previews: PreviewProvider {
    static var previews: some View {
        SecondStoryView()
    }
}

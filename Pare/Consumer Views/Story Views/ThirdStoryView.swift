//
//  ThirdStoryView.swift
//  Pare
//
//  Created by Karthik  Ramu on 6/2/23.
//

import SwiftUI

struct ThirdStoryView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var authViewModel: AuthViewModel
    let customColor = Color(red: 43/255, green: 74/255, blue: 238/255)

    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading){

            // Main message
            Group{
                Text("With Pare, money that went to middlemen goes to ")
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
                Text("So you ")
                    .font(.title.weight(.bold))

                +

                Text("**save more**")
                    .foregroundColor(Color.accentColor)
                    .font(.title.weight(.bold))

            }
            .padding()
            .padding(.bottom, 0)


            VStack(alignment: .leading, spacing: 10){

                // Image title
                Text("The avg. person spends $2,784 per year for eating out.")
                    .font(.title2)
                    .padding()
                    .padding(.bottom, 0)

                // Image
                Image("savings_graph")
                    .resizable()
                    .scaledToFit()
                    .padding()

            } //: VSTACK

            Spacer()

            HStack{
                Spacer()

                // Show FourthStoryView
                NavigationLink {
                    FourStoryView()
                } label: {

                    Text("Next")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(customColor)
                                .frame(width: 300, height: 50)
                        )
                        .frame(width:300,height:50)

                } //: BUTTON
                .padding(.bottom, 35)

                
                Spacer()

            } //: HSTACK



        } //: VSTACK
    }
}


// MARK: - PREVIEW 
struct ThirdStoryView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdStoryView()
    }
}

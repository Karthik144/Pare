//
//  ItemCell.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct ItemCell: View {

    // MARK: - PROPERTIES

    // MARK: - BODY
    var body: some View {


        HStack{

            Image("OttoBowl")
                .resizable()
                .frame(width: 85, height: 80)
                .scaledToFit()
                .cornerRadius(5)


            VStack(alignment: .leading){

                Text("Istanbowl")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)

                Text("Try our delicious bowl with white rice, mixed greens...")
                    .multilineTextAlignment(.leading)
                    .font(.caption)
                    .foregroundColor(Color.gray)



                HStack{

                    Text("10.95 USDC")
                        .font(.callout)
                        .foregroundColor(Color.black)


                    HStack{
                        Image("GlowingStar")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .scaledToFit()

                        Text("Earn 5 rewards")
                            .font(.callout)
                            .foregroundColor(Color.black)
                    } //: HSTACK
                    .padding(.leading, 5)



                } //: HSTACK


            } //: VSTACK

        } //: HSTACK
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell()
    }
}

//
//  ShopCell.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct ShopCell: View {

    // MARK: - PROPERTIES
//    let shopName: String
//    let shopType: String
//    let rating: String
//    let timeOpen: String
//    let distance: String

    // MARK: - BODY
    var body: some View {

        VStack(spacing: 10){

            HStack{
                Text("Otto Turkish Street Food")
                    .font(.title3)
                    .foregroundColor(Color.black)
                Spacer()
            }
            .padding(.leading, 15)

            HStack{

                Text("Food")
                    .font(.callout)
                    .foregroundColor(Color.white)
                    .background(
                        Capsule()
                            .foregroundColor(Color.green)
                            .frame(width: 51, height: 21)
                    )

                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.black)
                    Text("4.86")
                        .foregroundColor(Color.black)
                } //: HStack
                .padding(.leading, 10)

                Spacer()

            } //: HSTACK
            .padding(.leading, 20)



            HStack{
                Text("Open Now")
                    .foregroundColor(Color.gray)

                Text("2.8 mi")
                    .foregroundColor(Color.gray)

                Spacer()
            } //: HSTACK
            .padding(.leading, 20)

        } //: VSTACK
    }
}

struct ShopCell_Previews: PreviewProvider {
    static var previews: some View {
        ShopCell()
    }
}

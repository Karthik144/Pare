//
//  ShopCell.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI
import Kingfisher

struct ShopCell: View {

    // MARK: - PROPERTIES
    let shop: Shop
//    let timeOpen: String
//    let distance: String

    // MARK: - BODY
    var body: some View {

        VStack(spacing: 10){

            HStack{
                Text(shop.name)
                    .font(.title3)
                    .foregroundColor(Color.black)
                Spacer()
            }
            .padding(.leading, 15)

            HStack{

                Text(shop.type)
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
                    Text(shop.rating)
                        .foregroundColor(Color.black)
                } //: HStack
                .padding(.leading, 10)

                Spacer()

            } //: HSTACK
            .padding(.leading, 20)



            HStack{
                Text("Open Now")
                    .foregroundColor(Color.gray)

                Circle()
                    .frame(width: 2, height: 2)
                    .foregroundColor(Color.gray)

                Text("2.8 mi")
                    .foregroundColor(Color.gray)

                Spacer()
            } //: HSTACK
            .padding(.leading, 20)

        } //: VSTACK
    }
}

//struct ShopCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopCell()
//    }
//}

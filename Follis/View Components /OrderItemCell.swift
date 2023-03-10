//
//  OrderItem.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct OrderItemCell: View {

    // MARK: - PROPERTIES
    let itemQuantity: String
    let itemName: String
    let itemPrice: Double
    let rewardPoints: String 


    // MARK: - BODY
    var body: some View {
        HStack{

            Text(itemQuantity)
                .overlay(
                    RoundedRectangle(cornerRadius: 2, style: .circular)
                        .stroke(Color(red: 0.167, green: 0.29, blue: 0.933), lineWidth: 0.5)
                        .frame(width: 20, height: 20)

                 )
                .padding(.trailing, 8)

            Text(itemName)
                .foregroundColor(.black)

            Spacer()

            Text("\(String(itemPrice)) USDC")
                .padding()

            HStack{
                Image("GlowingStar")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .scaledToFit()

                Text("+\(rewardPoints)")

            } //: HSTACK


        } //: HSTACK
    }
}

//struct OrderItem_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderItemCell()
//    }
//}

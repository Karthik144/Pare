//
//  OrderStatusModalView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct OrderStatusModalView: View {

    // MARK: - PROPERTIES
    let shop: String
    let address: String
    let orderNumber: String
    let orderStatus: String


    // MARK: - BODY
    var body: some View {
        VStack{

            Capsule()
                .foregroundColor(Color.gray)
                .frame(width: 85, height: 8)
                .padding()

            Spacer()

            VStack(spacing: 5){

                Text(shop)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(address)
                    .font(.caption)
                    .foregroundColor(Color.gray)

            } //: VSTACK
            .padding()

            Spacer()

            VStack(spacing: 3){
                Text("Order \(orderNumber)")
                    .font(.largeTitle)
                    .font(.system(size: 80))
                    .fontWeight(.bold)

                Text(orderStatus)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.yellow)

                Text("Karthik Ramu")
                    .font(.title)
                    .foregroundColor(Color.black)
                    .padding(20)

            }

            Spacer()


            VStack(alignment: .leading){


                Text("Your Order")
                    .font(.title3)
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
                    .padding(.leading, 20)

                ForEach((0...1), id: \.self) {_ in

                    OrderItemCell(itemQuantity: 1, itemName: "Istanbowl", itemPrice: 10.95, rewardPoints: "5")
                        .padding(.leading, 25)
                        .padding(.trailing, 20)

                } //: FOR EACH

                Divider()

                HStack{

                    Text("Subtotal")

                    Spacer()

                    Text("20.9 USDC")

                } //: HSTACK
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 10)

                HStack{

                    Text("Tax")

                    Spacer()

                    Text("1.254 USDC")

                } //: HSTACK
                .padding(.leading, 20)
                .padding(.trailing, 20)


                Divider()

                HStack{

                    Text("Total")

                    Spacer()

                    Text("22.154 USDC")

                } //: HSTACK
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)


            }

            Spacer()

        } //: VSTACK
    }



}



// MARK: - PREVIEW
struct OrderStatusModalView_Previews: PreviewProvider {
    static var previews: some View {
        ShopsView()
    }
}

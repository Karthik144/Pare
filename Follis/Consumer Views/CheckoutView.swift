//
//  CheckoutView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct CheckoutView: View {

    // MARK: - PROPERTIES


    // MARK: - BODY
    var body: some View {

        VStack{


            VStack(alignment: .leading){

                HStack{

                    Image("OttoStore")
                        .resizable()
                        .frame(width: 115, height: 115)
                        .scaledToFit()
                        .cornerRadius(7)

                    VStack(alignment: .leading){

                        Text("Otto Turkish Street Food")
                            .font(.title3)
                            .fontWeight(.bold)

                        Text("111 W Water St, Charlottesville, VA 22902")
                            .foregroundColor(Color.gray)

                        Text("Pickup")
                            .foregroundColor(Color.green)


                    } //: VSTACK
                    .padding(.leading, 5)

                } //: HSTACK
                .padding()


                Text("Your Order")
                    .font(.title3)
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
                    .padding(.leading, 20)

                ForEach((0...1), id: \.self) {_ in

                    OrderItemCell(itemQuantity: "1", itemName: "Istanbowl", itemPrice: "10.95", rewardPoints: "5")
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



            } //: VSTACK

            Spacer()


            VStack(spacing: 30){

                Button {

                } label: {
                    Text("Pay")
                        .foregroundColor(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: 300, height: 50)
                        )
                }

                Button {

                } label: {
                    Text("Pay with stars 🌟")
                        .frame(width: 300, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .stroke(Color.accentColor, lineWidth: 1)
                        )
                }
            }



            Spacer()

        }


    }
}


// MARK: - PREVIEW 
struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}

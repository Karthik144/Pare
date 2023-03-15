//
//  OrderStatusModalView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct OrderStatusModalView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: ShopViewModel
    let shop: String
    let address: String
    let orderNumber: String
    let orderStatus: String
    
    @State var total = 0.0
    @State var subtotal = 0.0
    @State var tax = 0.0





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

                ScrollView{
                    ForEach(viewModel.cartItems) { order in
                        
                        
                        let index = viewModel.cartItems.firstIndex(of: order)
                        let itemPrice = Double(order.item.price)! + Double(order.getAddOns())!
                        
                        OrderItemCell(itemQuantity: order.item.quantity!, itemName: order.item.name, itemPrice: String(itemPrice), rewardPoints: order.item.rewards, index: index!, popup:false, finalTotal: total)
                            .padding(.leading, 25)
                            .padding(.trailing, 20)
                        
                    } //: FOR EACH
                } //: SCROLLVIEW
                .frame(height: 150)

                Divider()

                HStack{

                    Text("Subtotal")

                    Spacer()

                    Text(String(round(viewModel.subtotal * 100) / 100.0) + " USDC")

                } //: HSTACK
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 10)

                HStack{

                    Text("Tax")

                    Spacer()

                    Text(String(viewModel.tax) + " USDC")

                } //: HSTACK
                .padding(.leading, 20)
                .padding(.trailing, 20)


                Divider()

                HStack{

                    Text("Total")

                    Spacer()

                    Text(String(viewModel.total) + " USDC")

                } //: HSTACK
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)


            }

            Spacer()

            Button {
                viewModel.updatePendingOrders()
                viewModel.cartItems = []
                
                viewModel.total = 0.0
                viewModel.subtotal = 0.0
                viewModel.tax = 0.0
                
            } label: {
                Text("I Have My Food!")
            }
            .padding()

            Spacer()


        } //: VSTACK
        .onAppear(){
            total = viewModel.calcTotal()
        }
    }



}



// MARK: - PREVIEW
struct OrderStatusModalView_Previews: PreviewProvider {
    static var previews: some View {
        ShopsView()
    }
}

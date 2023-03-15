//
//  CheckoutView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct CheckoutView: View {

    // MARK: - PROPERTIES
    let shop: Shop
    @State var total = 0.0
    @State var subtotal = 0.0
    @State var tax = 0.0
    @EnvironmentObject var viewModel: ShopViewModel
    @EnvironmentObject var appState: AppState



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

                        Text(shop.name)
                            .font(.title3)
                            .fontWeight(.bold)

                        Text(shop.address)
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



            } //: VSTACK

            Spacer()


            VStack(spacing: 30){

                Button {
                    
                    let requestedAmt = viewModel.total * (pow(10,6))
                    let url = URL(string: "https://metamask.app.link/send/0x2791bca1f2de4661ed88a30c99a7a9449aa84174@137/transfer?address=0x14DA5EEF615205F7D3ddf80F8a0752f7F7Dfe4F6&uint256=\(requestedAmt)")!
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        //If you want handle the completion block than
                        UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                             print("Open url : \(success)")
                        })
                    }
                    // Change cart active status
                    viewModel.updateCartActiveStatus(cartActive: false)
                    
                    //Empty out cart
                    viewModel.cartItems = []
                    
                    

                    // Upload order to Firebase (so shop can access it) 

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

                    // Change cart active status
                    viewModel.updateCartActiveStatus(cartActive: false)

                    // Update user's rewards 
                    viewModel.updateRewards(rewards: viewModel.rewards)

                    // Upload order to Firebase (so shop can access it)
                    viewModel.postOrderData(shop: shop, cartTotalItems: String(viewModel.cartItems.count), cart: viewModel.cartItems, orderStatus: "pending", subtotal: viewModel.subtotal, total: viewModel.total)

                    //Pop to Shop View
                    self.appState.moveToDashboard = true

                } label: {
                    Text("Pay with stars 🌟")
                        .frame(width: 300, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .stroke(Color.accentColor, lineWidth: 1)
                        )
                }


            } //: VSTACK



            Spacer()

        } //: VSTACK
        .onAppear(){
            total = viewModel.calcTotal()
            print("WHEN CHECKOUT VIEW APPEARS")
        }


    }


//    func calcItemAddOnTotal(item: MenuItem) -> Double{
//
//        var addOptionsPrice = 0.0
//
//        // Find all add options for that item
//        let itemAddOptions = viewModel.selectedAddOptions[item]
//
//        for each in itemAddOptions ?? [] {
//
//            addOptionsPrice += Double(each.price) ?? 0.0
//        }
//
//        return addOptionsPrice
//
//    }

//    func calcTotal() {
//
////        var addOptionsPrice = 0.0
//
//        // Find items in cart
//        for cartItem in viewModel.cartItems {
//
//            subtotal += (Double(cartItem.price) ?? 0.0) + calcItemAddOnTotal(item: cartItem)
//
//        }
//
//        tax = 0.06 * subtotal
//
//        total = 1.06 * subtotal
//
//
//        total = round(total * 100) / 100.0
//
//
////        for each in viewModel.selectedAddOptions.keys {
////            addOptionsPrice += Double(viewModel.selectedAddOptions[each]?.price ?? "0.0") ?? 0.0
////        }
////
////        subtotal = Double(item.price) ?? 0.0 + addOptionsPrice
////
////        tax = 0.06 * subtotal
////
////        total = 1.06 * subtotal
////
////        total = round(total * 100) / 100.0
//
//    } //: FUNC CALC TOTAL
}


// MARK: - PREVIEW 
//struct CheckoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckoutView()
//    }
//}

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
    @State private var total = 0.0
    @State private var subtotal = 0.0
    @State private var tax = 0.0
    @EnvironmentObject var viewModel: ShopViewModel



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

//                ForEach((0...1), id: \.self) {_ in

                ForEach(viewModel.cartItems) { item in

                    let itemTotal = viewModel.calcItemAddOnTotal(item: item) + (Double(item.price) ?? 0.0)
 
                    
                    OrderItemCell(itemQuantity: item.quantity!, itemName: item.name, itemPrice: itemTotal, rewardPoints: item.rewards)
                        .padding(.leading, 25)
                        .padding(.trailing, 20)

                } //: FOR EACH

                Divider()

                HStack{

                    Text("Subtotal")

                    Spacer()

                    Text(String(subtotal) + " USDC")

                } //: HSTACK
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 10)

                HStack{

                    Text("Tax")

                    Spacer()

                    Text(String(tax) + " USDC")

                } //: HSTACK
                .padding(.leading, 20)
                .padding(.trailing, 20)


                Divider()

                HStack{

                    Text("Total")

                    Spacer()

                    Text(String(total) + " USDC")

                } //: HSTACK
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)



            } //: VSTACK

            Spacer()


            VStack(spacing: 30){

                Button {
                    let url = URL(string: "https://metamask.app.link/send/0x2791bca1f2de4661ed88a30c99a7a9449aa84174@137/transfer?address=0x14DA5EEF615205F7D3ddf80F8a0752f7F7Dfe4F6&uint256=1e7")!
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        //If you want handle the completion block than
                        UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                             print("Open url : \(success)")
                        })
                    }
                    // Change cart active status
                    viewModel.updateCartActiveStatus(cartActive: false)

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

                    // Upload order to Firebase (so shop can access it)

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
            viewModel.calcTotal()
            print("WHEN CHECKOUT VIEW APPEARS")
            print(viewModel.cartItems.count)

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

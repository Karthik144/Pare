//
//  CheckoutView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI
import Kingfisher 

struct CheckoutView: View {

    // MARK: - PROPERTIES
    let shop: Shop
    @State var total = 0.0
    @State var subtotal = 0.0
    @State var tax = 0.0
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var viewModel: ShopViewModel
    @EnvironmentObject var appState: AppState

    @State private var showingAlert = false
    @Binding var rootActive: Bool


    // MARK: - BODY
    var body: some View {

        VStack{


            VStack(alignment: .leading){

                HStack{

                    KFImage(URL(string: shop.image))
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


                HStack{

                    Text("Your Order")
                        .font(.title3)
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .padding(.leading, 20)


                    Spacer()

                    Button {

                        // Show popup with textfield

                    } label: {


                        Text("Add Note")
                            .frame(width: 100, height: 25)
                            .foregroundColor(Color.accentColor)
                            .overlay(

                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )

                    }
                    .padding()


                }


                ScrollView{
                    ForEach(viewModel.cartItems) { order in
                        
                        
                        let index = viewModel.cartItems.firstIndex(of: order)
                        let itemPrice = Double(order.item.price)! + Double(order.getAddOns())!
                        
                        
                        OrderItemCell(itemQuantity: order.item.quantity!, itemName: order.item.name, itemPrice: order.item.price, rewardPoints: order.item.rewards, index: index!, popup:false, finalTotal: total)
                            .padding(.leading, 25)
                            .padding(.trailing, 20)
                            .onAppear{
                                order.item.price = String(itemPrice)
                            }
                            .onAppear(){
                                let index = viewModel.cartItems.firstIndex(of: order)

                                print("Index inside on Appear")
                                print(index)
                            }
                        
                    } //: FOR EACH
                    .onAppear(){
                        print("Count of cart items")
                        print(viewModel.cartItems.count)
                    }
                    
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

                HStack{

                    Text("Rewards Earned")

                    Spacer()

                    Text(String(viewModel.totalRewards) + " 🌟")

                } //: HSTACK
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)




            } //: VSTACK

            Spacer()


            VStack(spacing: 30){

                NavigationLink(destination: PaySubView(shop: shop, rootIsActive: $rootActive)){

                    Text("Pay")
                        .foregroundColor(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: 300, height: 50)
                        )
                }

//                Button {
//
//                    let requestedAmt = viewModel.total * (pow(10,6))
//                    let url = URL(string: "https://metamask.app.link/send/0x2791bca1f2de4661ed88a30c99a7a9449aa84174@137/transfer?address=0xA741b63997bbF5AaC72bd36380533aaE0f419b14&uint256=\(requestedAmt)")!
//                    if UIApplication.shared.canOpenURL(url) {
//                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                        //If you want handle the completion block than
//                        UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
//                             print("Open url : \(success)")
//                        })
//                    }
//                    // Change cart active status
//                    viewModel.updateCartActiveStatus(cartActive: false)
//
//                    // Store users rewards
//                    let userRewards = Double(authViewModel.currentUser?.rewards ?? 0.0)
//
//                    // Find new total rewards from purchase
//                    let totalFinalRewards = userRewards + viewModel.totalRewards
//
//                    // Update rewarads in firebase
//                    viewModel.updateRewards(rewards: totalFinalRewards)
//
//                    // Upload order to Firebase (so shop can access it)
//                    viewModel.postOrderData(shop: shop, cartTotalItems: String(viewModel.cartItems.count), cart: viewModel.cartItems, orderStatus: "pending", subtotal: viewModel.subtotal, total: viewModel.total, user: authViewModel.currentUser!, rewards: false)
//
//
//                    //Empty out cart
//                    viewModel.cartItems = []
//
//                    //Pop to Shop View
//                    rootActive = false
//
//                } label: {
//                    Text("Pay")
//                        .foregroundColor(Color.white)
//                        .background(
//                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
//                                .fill(Color.accentColor)
//                                .frame(width: 300, height: 50)
//                        )
//                }

                Button {

                    // Change cart active status
                    viewModel.updateCartActiveStatus(cartActive: false)

                    // Store users rewards
                    var userRewards = Double(authViewModel.currentUser?.rewards ?? 0.0)

                    if userRewards >= viewModel.total{

                        // Subtract used rewards from new rewards and update it to total rewards
                        let extraRewards = userRewards - viewModel.total

                        let updatedRewards = (viewModel.totalRewards) + extraRewards

                        // Update user's rewards with new rewards from purchase
                        viewModel.updateRewards(rewards: Double(updatedRewards))

                        // Upload order to Firebase (so shop can access it)
                        viewModel.postOrderData(shop: shop, cartTotalItems: String(viewModel.cartItems.count), cart: viewModel.cartItems, orderStatus: "pending", subtotal: viewModel.subtotal, total: viewModel.total, user: authViewModel.currentUser!, rewards: true)

                        //Empty out cart
                        viewModel.cartItems = []

                        //Pop to Shop View
                        rootActive = false

                    } else {

                        showingAlert = true

                    }

//                    // Update user's rewards with new rewards from purchase
//                    viewModel.updateRewards(rewards: viewModel.rewards)
//
//
//                    // Upload order to Firebase (so shop can access it)
//                    viewModel.postOrderData(shop: shop, cartTotalItems: String(viewModel.cartItems.count), cart: viewModel.cartItems, orderStatus: "pending", subtotal: viewModel.subtotal, total: viewModel.total, user: authViewModel.currentUser!)
//
//                    //Empty out cart
//                    viewModel.cartItems = []
//
//                    //Pop to Shop View
////                    self.appState.moveToDashboard = true

                    rootActive = false 

                } label: {
                    Text("Pay with stars 🌟")
                        .frame(width: 300, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .stroke(Color.accentColor, lineWidth: 1)
                        )
                }
                .alert("Not enough rewards!", isPresented: $showingAlert) {
                    Button("Ok", role: .cancel) { }
                }


            } //: VSTACK



            Spacer()

        } //: VSTACK
        .onAppear(){
            total = viewModel.calcTotal()
            viewModel.totalRewards = viewModel.calcTotalRewards()
        }


    }

}


// MARK: - PREVIEW 
//struct CheckoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckoutView()
//    }
//}

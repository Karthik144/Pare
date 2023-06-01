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
    @EnvironmentObject var sheetManager: SheetManager

    @State private var showingAlert = false
    @State private var showingWalletAlert = false

    @State var noteText = ""
    @State var rewards = false
    @Binding var rootActive: Bool


    // MARK: - BODY
    var body: some View {

        VStack{

            Spacer()

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
                .padding(.top, 50)


                HStack{

                    Text("Your Order")
                        .font(.title3)
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .padding(.leading, 20)


                    Spacer()

                    Button {

                        // Show popup with textfield
                        sheetManager.present()


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
            } //: VSTACK
            .padding(.top, 40)


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
                        }

                } //: FOR EACH
      

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
                .padding(.bottom, 20)
                .padding(.leading, 20)
                .padding(.trailing, 20)


                Spacer()


                VStack(spacing: 30){

                    if authViewModel.currentUser?.wallet == false {

                        Button {
                            showingWalletAlert = true
                        } label: {
                            Text("Pay")
                                .foregroundColor(Color.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                        .fill(Color.accentColor)
                                        .frame(width: 300, height: 50)
                                )
                        }
                        .alert("You haven't set up your wallet yet. Go to your Profile to finish setup.", isPresented: $showingWalletAlert) {
                            Button("Ok", role: .cancel) { }
                        }

                    } else {

                        NavigationLink(destination: PayOptionView(shop: shop, rewards: rewards, rootIsActive: $rootActive, noteText: noteText)){

                            Text("Pay")
                                .foregroundColor(Color.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                        .fill(Color.accentColor)
                                        .frame(width: 300, height: 50)
                                )
                        } //: NAV LINK

                    } //: ELSE


                    if rewards == false {

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
                                viewModel.postOrderData(shop: shop, cartTotalItems: String(viewModel.cartItems.count), cart: viewModel.cartItems, orderStatus: "pending", subtotal: viewModel.subtotal, total: viewModel.total, user: authViewModel.currentUser!, rewards: true, notes: noteText)

                                //Empty out cart
                                viewModel.cartItems = []

                                //Pop to Shop View
                                rootActive = false

                            } else {

                                // Subtract total from rewards to get new price
                                // 5.67 - 1 = 4.67
                                let newTotal = viewModel.total - userRewards
                                let newSubTotal = viewModel.subtotal - userRewards

                                // new total: 4.67
                                viewModel.total = newTotal


                                viewModel.totalRewards = (newSubTotal) * 0.10

                                // 0.10 x 4.67 = 0.467
                                // Update user's rewards with new rewards from purchase
                                viewModel.updateRewards(rewards: Double(viewModel.totalRewards))

                                rewards = true

                            }


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

                    } //: IF STATEMENT



                } //: VSTACK
                .padding()

                Spacer()


            } //: SCROLL VIEW


        } //: VSTACK
        .onAppear(){
            total = viewModel.calcTotal()
            viewModel.totalRewards = viewModel.calcTotalRewards()
        }
        .overlay(alignment: .bottom){

            if sheetManager.action.isPresented {
                PopUpView(instructions: $noteText){

                    withAnimation {
                        sheetManager.dismiss()
                    }
                }
            }

        }
        .ignoresSafeArea()


    } //: VIEW

}


// MARK: - PREVIEW 
//struct CheckoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckoutView()
//    }
//}

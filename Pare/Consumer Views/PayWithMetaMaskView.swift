//
//  PayWithMetaMaskView.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/17/23.
//

import SwiftUI

struct PayWithMetaMaskView: View {

    // MARK: - PROPERTIES
    let shop: Shop
    let rewards: Bool
    private let pasteboard = UIPasteboard.general
    @Binding var rootIsActive: Bool

    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var viewModel: ShopViewModel
    @EnvironmentObject var appState: AppState


    let noteText: String


    // MARK: - BODY
    var body: some View {

        ScrollView{
            VStack{

                HStack{

                    Text("Follow these steps on your wallet. Select the confirm payment button to finish your order.")
                        .fontWeight(.light)
                        .padding()

                    Spacer()
                } //: HSTACK

                VStack(){
                    HStack{
                        Text("Total: $")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text(String(viewModel.total))
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading, 0)
                            .foregroundColor(Color.accentColor)
                    }

                    HStack{

                        HStack{

                            ZStack{

                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.accentColor)


                                Text("1")
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)

                            } //: ZSTACK
                            .padding(.trailing, 10)


                            Text("Select Send")
                                .font(.title2)
                                .fontWeight(.medium)

                        } //: HSTACK

                        Spacer()
                    }
                    .padding()


                    Image("SendStep")
                        .resizable()
                        .frame(width: 335, height: 90)
                        .scaledToFit()
                        .cornerRadius(5)

                } //: VSTACK

                // Copy address
                VStack(){

                    HStack{

                        HStack{

                            ZStack{

                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.accentColor)


                                Text("3")
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)

                            } //: ZSTACK
                            .padding(.trailing, 10)


                            Text("Copy address into To field")
                                .font(.title2)
                                .fontWeight(.medium)

                        } //: HSTACK

                        Spacer()
                    }
                    .padding()

                    HStack{



                        Button {
                            copyToClipboard()
                        } label: {

                            HStack{


                                Spacer()

                                HStack{
                                    Text("Copy")
                                        .font(.title3)

                                    Image(systemName: "doc.on.doc")
                                } //: HSTACK

                                Spacer()


                            } //: HSTACK


                            //                        Label("Copy", systemImage: "doc.on.doc")
                            //                            .frame(width: 100, height: 100)
                        }
                        //                    .padding(.leading)

                        Spacer()

                    } //: HSTACK

                } //: VSTACK


                VStack(){

                    HStack{

                        HStack{

                            ZStack{

                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.accentColor)


                                Text("2")
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)

                            } //: ZSTACK
                            .padding(.trailing, 10)


                            Text("Click on DropDown & select USD")
                                .font(.title2)
                                .fontWeight(.medium)

                        } //: HSTACK

                        Spacer()
                    }
                    .padding()

                    HStack{

                        Image("SelectCoinToSend")
                            .resizable()
                            .frame(width: 335, height: 90)
                            .scaledToFit()
                            .cornerRadius(5)

                    } //: HSTACK

                } //: VSTACK



                HStack{

                    HStack{

                        ZStack{

                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color.accentColor)


                            Text("4")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)

                        } //: ZSTACK
                        .padding(.trailing, 10)


                        Text("Enter total order amount")
                            .font(.title2)
                            .fontWeight(.medium)

                    } //: HSTACK

                    Spacer()

                } //: HSTACK
                .padding()


            } //: VSTACK
            .navigationTitle("Pay With MetaMask")
            .navigationBarTitleDisplayMode(.large)
        }
        Spacer()

        //            NavigationLink(destination: PaySubView()){
        //
        //                Text("Confirm Payment")
        //                    .foregroundColor(Color.white)
        //                    .background(
        //                        RoundedRectangle(cornerRadius: 8,  style: .continuous)
        //                            .fill(Color.accentColor)
        //                            .frame(width: 300, height: 50)
        //                    )
        //            }

        Button {

            // Change cart active status
            viewModel.updateCartActiveStatus(cartActive: false)

            // Store users rewards
            let userRewards = Double(authViewModel.currentUser?.rewards ?? 0.0)

            if rewards != true {
                // Find new total rewards from purchase
                let totalFinalRewards = userRewards + viewModel.totalRewards

                // Update rewarads in firebase
                viewModel.updateRewards(rewards: totalFinalRewards)
            }

            // Upload order to Firebase (so shop can access it)
//            viewModel.postOrderData(shop: shop, cartTotalItems: String(viewModel.cartItems.count), cart: viewModel.cartItems, orderStatus: "pending", subtotal: viewModel.subtotal, total: viewModel.total, user: authViewModel.currentUser!, rewards: rewards, notes: noteText)


            //Empty out cart
            viewModel.cartItems = []

            //Pop to Shop View
            rootIsActive = false

        } label: {
            Text("Confirm Payment")
                .foregroundColor(Color.white)
                .background(
                    RoundedRectangle(cornerRadius: 8,  style: .continuous)
                        .fill(Color.accentColor)
                        .frame(width: 300, height: 50)
                )
        }
        .padding()


        Spacer()

    }

    func copyToClipboard(){

        //pasteboard.string = "0x2791bca1f2de4661ed88a30c99a7a9449aa84174" *Commented out for testing*
        pasteboard.string = "0xA741b63997bbF5AaC72bd36380533aaE0f419b14"

    } //: FUNC COPY TO CLIP
}


// MARK: - PREVIEW
//struct PayWithMetaMaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        PayWithMetaMaskView()
//    }
//}

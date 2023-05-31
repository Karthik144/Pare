//
//  ShopsView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI
import MagicSDK
import MagicSDK_Web3

struct ShopsView: View {
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }()
    

    // MARK: - PROPERTIES
    @ObservedObject private var viewModel = ShopViewModel()
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var walletViewModel: WalletViewModel
    @StateObject var magicSingleton = MagicSingleton.shared
    @State var isViewActive: Bool = false
    @State private var orderScheduled = true
    @State private var showModal = false
    @State private var totalShops = [Shop]()
    @State private var pendingOrders = [PendingOrder]()
    @State private var filteredPendingOrders = [PendingOrder]()
    @State private var tokenBalance: BigUInt = 0
    @State private var readyOrders = [PendingOrder]()

    
    @State var orderDone: Bool = false
    @State var orderReady: Bool = false
    
    @State var pickUpTime: Date?

    @State var isActive : Bool = false

    // MARK: - BODY
    var body: some View {

        NavigationView {

            VStack{

                SearchBar()
                    .padding(.top, 10)

                //Show ModalView Conditional Block
                if orderReady == true{


                    ZStack{

                        RoundedRectangle(cornerRadius: 7, style: .continuous)
                            .fill(Color.accentColor)
                            .frame(width: 340, height: 75)


                        HStack{

                            Spacer()


                            VStack(alignment: .leading, spacing: 0){
                                
                                if let firstOrder = readyOrders.first {
                                    Text("Order Ready for Pickup")
                                        .foregroundColor(Color.white)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                } else {
                                    Text("Order Scheduled")
                                        .foregroundColor(Color.white)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                
                                HStack{

                                    if let firstOrder = readyOrders.first {
                                        Text("Ready")
                                            .font(.caption)
                                            .foregroundColor(Color.white)
                                            .fontWeight(.light)
                                    } else {
                                        Text("In Progress")
                                            .font(.caption)
                                            .foregroundColor(Color.white)
                                            .fontWeight(.light)
                                    }
                                    

                        
                                    Circle()
                                        .frame(width: 2, height: 2)
                                        .foregroundColor(Color.white)

                                    Text(dateFormatter.string(from: pickUpTime!))
                                        .font(.caption)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.light)
                                }
                            }

                            Spacer()


                            Image(systemName: "clock.badge.checkmark")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 30, height: 30)


                            Spacer()

                        } //: HSTACK

                    } //: ZSTACK
                    .onTapGesture {
                        showModal.toggle()
                    }.sheet(isPresented: $showModal) {
                        OrderStatusModalView(shop: "Yuanho Gao Chinese", address: "117 Maury Ave, Charlottesville, VA 22903", orderNumber: "#325", orderStatus: "In Progress", orderReady: $orderReady, showModal: $showModal)
                    }

                } //: IF ORDER READY

                if authViewModel.currentUser?.wallet == false {

                    NavigationLink {
                        AddFundsView()
                    } label: {
                        AddFundsCell()

                    }

                } //: IF WALLET NOT FULLY SETUP


                HStack{
                    Text("Near You")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .padding(.leading, 10)

                    Spacer()
                }

                ScrollView {


                    LazyVStack{

                        ForEach(totalShops) { shop in

                            Button {
                                self.isActive = true

                            } label: {
                                ShopCell(shop: shop)
                                    .padding(.leading, 0)
                                    .padding()
                            }
                            .background(

                                NavigationLink(destination: ShopItemView(rootIsActive: $isActive, shop: shop),
                                                isActive: $isActive) {EmptyView()}
                            )

//
//                            NavigationLink(destination: ShopItemView(shop: shop)) {
//                                ShopCell(shop: shop)
//                                    .padding(.leading, 0)
//                                    .padding()
//                            }
//                            .isDetailLink(false)
//                            NavigationLink {
//                                ShopItemView(shop: shop)
//                            } label: {
//                                ShopCell(shop: shop)
//                                    .padding(.leading, 0)
//                                    .padding()
//                            }

                        } //: FOR EACH
                        .onAppear{
                            print(self.totalShops)
                        }
                    } //: LAZYVSTACK
                    

                } //: SCROLL VIEW


            } //: VSTACK
            .onAppear(){
                viewModel.fetchShops { shops in
                    self.totalShops = shops
                }

                walletViewModel.getBalance(magic: magicSingleton.magic, userPublicAddress: authViewModel.currentUser?.public_address ?? "") { balance in

                    if let balance = balance {
                        tokenBalance = balance

                    } else {
                        print("Error retrieving balance.")
                    }
                }

            } //: ON APPEAR


        } //: NAV VIEW
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){

            viewModel.fetchAllOrders{ orders in
                print(orders)
                for order in orders{
                    if (order.status == "ready" || order.status == "pending"){
                        self.pickUpTime = (orders[0].date_ordered).addingTimeInterval(20 * 60)
                        orderReady = true
                        if (order.status == "ready"){
                            self.readyOrders.append(order)
                        }
                    }

                }
            }


        } //: ON APPEAR

//        .onReceive(self.appState.$moveToDashboard) { moveToDashboard in
//            if moveToDashboard {
//                self.isViewActive = false
//                self.appState.moveToDashboard = false
//            }
//
//
//
//            viewModel.fetchAllOrders{ orders in
//                for order in orders{
//                    if (order.status == "ready" || order.status == "pending"){
//                        self.pickUpTime = (orders[0].date_ordered).addingTimeInterval(20 * 60)
//                        orderReady = true
//                        if (order.status == "ready"){
//                            self.readyOrders.append(order)
//                        }
//                    }
//
//                }
//            }
//
//        }

    } //: VIEW


}


// MARK: - PREVIEW
//struct ShopsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopsView()
//    }
//}

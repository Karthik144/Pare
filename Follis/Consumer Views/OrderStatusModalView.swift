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
    @EnvironmentObject var AuthViewModel: AuthViewModel
    let shop: String
    let address: String
    let orderNumber: String
    let orderStatus: String

    @State private var pendingOrders = [PendingOrder]()
    @State private var filteredPendingOrders = [PendingOrder]()
    @State private var orderItems = [OrderItem]()
    
    @State var total = 0.0
    @State var subtotal = 0.0
    @State var tax = 0.0

    @Binding var showModal: Bool



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

                if let firstOrder = filteredPendingOrders.first {

                    if firstOrder.pending == true {
                        Text(orderStatus)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                    } else {
                        Text("Complete")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.green)
                    }

                } else {
                    Text("No orders found")
                }


//                Text(orderStatus)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(Color.yellow)
                

                Text(AuthViewModel.currentUser!.first_name + " " + AuthViewModel.currentUser!.last_name)
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
//                    ForEach(viewModel.cartItems) { order in
//
//
//                        let index = viewModel.cartItems.firstIndex(of: order)
//                        let itemPrice = Double(order.item.price)! + Double(order.getAddOns())!
//
//                        OrderItemCell(itemQuantity: order.item.quantity!, itemName: order.item.name, itemPrice: String(itemPrice), rewardPoints: order.item.rewards, index: index!, popup:false, finalTotal: total)
//                            .padding(.leading, 25)
//                            .padding(.trailing, 20)
//
//                    } //: FOR EACH

                    ForEach(orderItems) { orderItem in

                        OrderItemCell(itemQuantity: Int(orderItem.quantity) ?? 1, itemName: orderItem.name, itemPrice: orderItem.price, rewardPoints: orderItem.rewards, index: 0, popup:true, finalTotal: 0)
                            .padding(.leading, 25)
                            .padding(.trailing, 20)

                    } //: FOR EACH

                } //: SCROLLVIEW
                .frame(height: 150)

                Divider()

                HStack{

                    Text("Subtotal")

                    Spacer()

//                    Text(String(round(filteredPendingOrders[0].subtotal * 100) / 100.0) + " USDC")

                    if let firstOrder = filteredPendingOrders.first {
                        Text(String(round(firstOrder.subtotal * 100) / 100.0) + " USDC")
                    } else {
                        Text("No orders found")
                    }

                } //: HSTACK
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 10)

                HStack{

                    Text("Tax")

                    Spacer()

//                    Text(String((round(filteredPendingOrders[0].subtotal * 100) / 100.0) * 0.06) + " USDC")


                    if let firstOrder = filteredPendingOrders.first {
                        Text(String((round(firstOrder.subtotal * 100) / 100.0) * 0.06) + " USDC")
                    } else {
                        Text("No orders found")
                    }

                } //: HSTACK
                .padding(.leading, 20)
                .padding(.trailing, 20)


                Divider()

                HStack{

                    Text("Total")

                    Spacer()

//                    Text(String(filteredPendingOrders[0].total) + " USDC")

                    if let firstOrder = filteredPendingOrders.first {
                        Text(String(firstOrder.total) + " USDC")
                    } else {
                        Text("No orders found")
                    }

                } //: HSTACK
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)


            }

            Spacer()

            Button {
//                viewModel.updatePendingOrders()
//                viewModel.cartItems = []
//
//                viewModel.total = 0.0
//                viewModel.subtotal = 0.0
//                viewModel.tax = 0.0

                // Update complete status
                if let firstOrder = filteredPendingOrders.first {

                    viewModel.updatePendingToComplete(pendingOrderID: firstOrder.id ?? "", complete: true)
                }

                showModal = false
                

                
            } label: {
                Text("I Have My Food!")
            }
            .padding()

            Spacer()


        } //: VSTACK
        .onAppear(){
            total = viewModel.calcTotal()

            viewModel.fetchPendingOrders { pendingOrders in
                self.pendingOrders = pendingOrders

                print("Number of pending orders \(self.pendingOrders.count)")
                for order in self.pendingOrders{

                    if order.pending == true && order.complete == false {
                        self.filteredPendingOrders.append(order)
                        print("Number of filtered pending orders \(self.filteredPendingOrders.count)")

                    }

                    if order.pending == false && order.complete == false {
                        self.filteredPendingOrders.append(order)
                    }

                }

                if !self.filteredPendingOrders.isEmpty{

                    print("Entered if not empty statement")

                    viewModel.fetchOrderItems(pendingOrderID: self.filteredPendingOrders[0].id ?? "") { orderItems in

                        self.orderItems = orderItems
                        print("Number of order items \(self.orderItems.count)")

                    }

                }

            }
        } //: ON APPEAR


    } //: VIEW 



}



// MARK: - PREVIEW
struct OrderStatusModalView_Previews: PreviewProvider {
    static var previews: some View {
        ShopsView()
    }
}

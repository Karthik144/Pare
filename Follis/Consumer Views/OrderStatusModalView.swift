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
    @State private var readyOrders = [PendingOrder]()
    @State private var orderItems = [OrderItem]()
    
    @State var total = 0.0
    @State var subtotal = 0.0
    @State var tax = 0.0
    
    @Binding var orderReady: Bool

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
                
                
                if let firstOrder = readyOrders.first {
                    if (firstOrder.status == "pending"){
                        Text(firstOrder.status)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                    }
                    else{
                        Text("Ready")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.green)
                    }
                    
                } else {
                    Text(orderStatus)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
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

                    if let firstOrder = readyOrders.first {
                        Text(String(round(firstOrder.subtotal * 100) / 100.0) + " USDC")
                    } else {
                        if let firstOrder = pendingOrders.first {
                            Text(String(round(firstOrder.subtotal * 100) / 100.0) + " USDC")
                        }
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


                    if let firstOrder = readyOrders.first {
                        Text(String((round(firstOrder.total * 100) / 100.0) * 0.06) + " USDC")
                    } else {
                        if let firstOrder = pendingOrders.first {
                            Text(String((round(firstOrder.total * 100) / 100.0) * 0.06) + " USDC")
                        }
                    }

                } //: HSTACK
                .padding(.leading, 20)
                .padding(.trailing, 20)


                Divider()

                HStack{

                    Text("Total")

                    Spacer()

//                    Text(String(filteredPendingOrders[0].total) + " USDC")

                    if let firstOrder = readyOrders.first {
                        Text(String(firstOrder.total) + " USDC")
                    } else {
                        if let firstOrder = pendingOrders.first {
                            Text(String(round(firstOrder.total * 100) / 100.0) + " USDC")
                        }
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
                if let firstOrder = readyOrders.first {

                    viewModel.updatePendingToComplete(pendingOrderID: firstOrder.id ?? "")
                }
                
                orderReady = false

                showModal = false
                

                
            } label: {
                Text("I Have My Food!")
            }
            .padding()

            Spacer()


        } //: VSTACK
        .onAppear(){
            total = viewModel.calcTotal()
            
            viewModel.fetchAllOrders{ orders in
                for order in orders{
                    if (order.status == "ready"){
                        self.readyOrders.append(order)
                    }
                    if (order.status == "pending"){
                        self.pendingOrders.append(order)
                    }
                    
                }
                
                if !self.pendingOrders.isEmpty{

                    viewModel.fetchOrderItems(pendingOrderID: self.pendingOrders[0].id ?? "") { orderItems in

                        self.orderItems = orderItems
                        print("Number of order items \(self.orderItems.count)")

                    }

                }
                
                if !self.readyOrders.isEmpty{

                    viewModel.fetchOrderItems(pendingOrderID: self.readyOrders[0].id ?? "") { orderItems in

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

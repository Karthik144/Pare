//
//  PastOrderView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/15/23.
//

import SwiftUI

struct PastOrderView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: ShopViewModel
    @State private var orders = [PendingOrder]()
    @State private var filteredPendingOrders = [PendingOrder]()

    // MARK: - BODY
    var body: some View {

        VStack{

            if filteredPendingOrders.isEmpty{

                Spacer()
                Text("No orders yet. Go out and treat yourself! 😀")
                    .foregroundColor(Color.gray)
                    .padding()
                Spacer()
            } else {

                ScrollView{
                    LazyVStack{

                        ForEach(filteredPendingOrders){ order in

                            PastOrderCell(order: order)
                        }
                        .padding()

                    } //: LAZY VSTACK
                } //: SCROLL VIEW

            } //: ELSE

            
        } //: VSTACK
        .navigationTitle("Order History")
        .navigationBarTitleDisplayMode(.large)
        .onAppear(){

            viewModel.fetchAllOrders{ orders in
                self.orders = orders

                for order in self.orders {

                    if order.status == "complete"{

                        self.filteredPendingOrders.append(order)
                    }
                }
            }

        } //: ON APPEAR



    }
}


// MARK: - PREVIEW 
struct PastOrderView_Previews: PreviewProvider {
    static var previews: some View {
        PastOrderView()
    }
}

//
//  PastOrderCell.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/15/23.
//

import SwiftUI

struct PastOrderCell: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: ShopViewModel
    @State private var shops = [Shop]()
    let order: PendingOrder


    // MARK: - BODY
    var body: some View {
        HStack{

            Image("TakeoutBox")
                .resizable()
                .frame(width: 45, height: 45)
                .scaledToFit()
                .padding()

            VStack(alignment: .leading){

                if let firstShop = shops.first {
                    Text(firstShop.name)
                        .font(.title2)
                        .foregroundColor(Color.black)
                } else {
                    Text("Shop")
                        .font(.title2)
                        .foregroundColor(Color.black)
                }

                VStack(alignment: .leading, spacing: 5){

                    HStack{

                        Text("$" + String(order.total))
                            .foregroundColor(Color.gray)



                        if Int(order.total_items) ?? 1 > 1{
                            Text(order.total_items + " Items")
                                .foregroundColor(Color.gray)

                        } else {
                            Text(order.total_items + " Item")
                                .foregroundColor(Color.gray)
                        }


                    } //: HSTACK

                    Text(dateFormatter.string(from: order.date_ordered))
                        .foregroundColor(Color.gray)

                } //: VSTACK


            } //: VSTACK

            Spacer()

            //            Image(systemName: "chevron.right")
            //                .padding()


        } //: HSTACK
        .onAppear(){

            // Fetch shop name
            viewModel.fetchShops { shops in
                for each in shops {

                    if each.id == order.shop_id{

                        self.shops.append(each)
                    }

                }
            }
        } //: ON APPEAR
    }

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
} //: VIEW




// MARK: - PREVIEW
//struct PastOrderCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PastOrderCell()
//    }
//}

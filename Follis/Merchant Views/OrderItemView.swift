//
//  OrderItemView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/16/23.
//

import SwiftUI

struct OrderItemView: View {

    // MARK: - PROPERTIES
    let itemName: String
    let itemPrice: String
    let itemQuantity: String

    // MARK: - BODY
    var body: some View {
        HStack{

            Text(itemQuantity)
                .overlay(
                    RoundedRectangle(cornerRadius: 2, style: .circular)
                        .stroke(Color(red: 0.167, green: 0.29, blue: 0.933), lineWidth: 0.5)
                        .frame(width: 20, height: 20)

                 )
                .padding(.trailing, 8)

            Text(itemName)
                .foregroundColor(.black)

            Spacer()

            Text("$\(itemPrice)")
                .padding()

        } //: HSTACK

    }
}


// MARK: - BODY
//struct OrderItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderItemView()
//    }
//}

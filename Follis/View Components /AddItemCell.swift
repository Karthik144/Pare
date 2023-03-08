//
//  AddItemCell.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct AddItemCell: View {

    // MARK: - PROPERTIES
    @Binding var didTap: Bool
    let addMoreType: Bool
    let price: String

    // MARK: - BODY
    var body: some View {

        if addMoreType == false{

            HStack{
                Image(systemName: didTap ? "circle.fill" : "circle")
                    .foregroundColor(.accentColor)
                    .padding(.trailing, 5)
                Text("Chicken (Regular)")
                    .foregroundColor(Color.black)
            } //: HSTACK

        } else {

            HStack{
                Image(systemName: didTap ? "circle.fill" : "circle")
                    .foregroundColor(.accentColor)
                    .padding(.trailing, 5)
                Text("Chicken (Regular)")
                    .foregroundColor(Color.black)

                Spacer()

                Text("+\(price) USDC")
                    .foregroundColor(Color.black)
                    .padding(.trailing, 15)
            } //: HSTACK

        }


    }
}


// MARK: - PREVIEW
//struct AddItemCell_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemCell()
//    }
//}

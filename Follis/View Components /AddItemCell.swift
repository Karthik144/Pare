//
//  AddItemCell.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct AddItemCell: View {

    // MARK: - PROPERTIES
    @State var didTap = false
    @EnvironmentObject var viewModel: ShopViewModel
    let item: MenuItem
    let addItem: Add

    // MARK: - BODY
    var body: some View {
        

        HStack{

            Button {
                didTap.toggle()

                // Append to array
                if didTap {

                    // Check if key exists in dictionary (then just append)

                    // If key does not exist
                    viewModel.selectedAddOptions[item, default: []].append(addItem)

                    print("WHEN TAPPED")
                    print(viewModel.selectedAddOptions[item]?.count)

                }

            } label: {
                Image(systemName: didTap ? "circle.fill" : "circle")
                    .foregroundColor(.accentColor)
                    .padding(.trailing, 5)
            }

            Text(addItem.option)
                .foregroundColor(Color.black)

            Spacer()

            Text("+\(addItem.price) USDC")
                .foregroundColor(Color.black)
                .padding(.trailing, 15)
        } //: HSTACK




    }
}


// MARK: - PREVIEW
//struct AddItemCell_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemCell()
//    }
//}

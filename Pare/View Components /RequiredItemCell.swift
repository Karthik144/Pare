//
//  AddItemCell.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct RequiredItemCell: View {

    // MARK: - PROPERTIES
    @State var didTap = false
    @EnvironmentObject var viewModel: ShopViewModel
    let requiredItem: Required
    @StateObject var order: Order

    // MARK: - BODY
    var body: some View {


        HStack{

            Button {
                didTap.toggle()

                // Append to array
                if didTap {
                    order.requiredSelection?.append(requiredItem)
                }

            } label: {
                Image(systemName: didTap ? "circle.fill" : "circle")
                    .foregroundColor(.accentColor)
                    .padding(.trailing, 5)
            }


            Text(requiredItem.option)
                .foregroundColor(Color.black)

            Spacer() 
        } //: HSTACK


    }
}


// MARK: - PREVIEW
//struct RequiredItemCell_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemCell()
//    }
//}


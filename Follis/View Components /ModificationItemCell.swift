//
//  AddItemCell.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct ModificationItemCell: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: ShopViewModel
    @State var didTap = false
//    @Binding var selectedItems: [MenuItem: [Modification]]
    let modificationItem: Modification
    var item: MenuItem

    // MARK: - BODY
    var body: some View {


        HStack{

            Button {
                didTap.toggle()

                // Append to array
                if didTap {

                    viewModel.selectedModificationOptions[item, default: []].append(modificationItem)
                }

            } label: {
                Image(systemName: didTap ? "circle.fill" : "circle")
                    .foregroundColor(.accentColor)
                    .padding(.trailing, 5)
            }


            Text(modificationItem.option)
                .foregroundColor(Color.black)

            Spacer()

        } //: HSTACK


    }
}


// MARK: - PREVIEW
//struct ModificationItemCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ModificationItemCell()
//    }
//}



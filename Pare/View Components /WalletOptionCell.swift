//
//  WalletOptionCell.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/28/23.
//

import SwiftUI

struct WalletOptionCell: View {

    // MARK: - PROPERTIES
    let title: String
    let subTitle: String
    let image: String

    // MARK: - BODY
    var body: some View {

        HStack{

            // Image
            Image(image)
                .resizable()
                .frame(width: 28, height: 28)
                .scaledToFit()
                .padding()

            // Title + Description
            VStack(alignment: .leading){

                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)

                Text(subTitle)
                    .fontWeight(.light)
                    .font(.caption)

            } //: VSTACK

            Spacer()

            // Right arrow
            Image(systemName: "chevron.right")
                .padding()

        } //: HSTACK
        .padding(.leading)
        .padding(.trailing)

    } //: VIEW
}


// MARK: - PREVIEW
//struct WalletOptionCell_Previews: PreviewProvider {
//    static var previews: some View {
//        WalletOptionCell()
//    }
//}

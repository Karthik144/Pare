//
//  AddFundsCell.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/28/23.
//

import SwiftUI

struct AddFundsCell: View {

    // MARK: - PROPERTIES
    let customColor = Color(UIColor(red: 0x86/255, green: 0x97/255, blue: 0xF3/255, alpha: 1.0))

    // MARK: - BODY
    var body: some View {

        ZStack(alignment: .leading){

            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.accentColor, customColor]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 340, height: 93)

            VStack(alignment: .leading){

                Text("Add funds to your wallet")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .padding(.leading)
                    .padding(.top, 6)

                Text("10% rewards and lowest meal prices")
                    .foregroundColor(Color.white)
                    .padding(.leading)


                HStack{

                    Text("Get Started")
                        .foregroundColor(Color.white)
                        .font(.caption)

                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.white)
                        .font(.caption)

                } //: HSTACK
                .padding(.leading)
                .padding(.top, 2)
                .padding(.bottom, 2)

            } //: VSTACK

        } //: ZSTACK
        .frame(width: 93, height: 340)
    }
}

// MARK: - PREVIEW
struct AddFundsCell_Previews: PreviewProvider {
    static var previews: some View {
        AddFundsCell()
    }
}

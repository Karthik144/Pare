//
//  txCell.swift
//  Follis
//
//  Created by Akhil Maheepathi on 2/17/23.
//

import Foundation
import SwiftUI

struct txCell: View {

    // MARK: - PROPERTIES
    @ObservedObject private var viewModel = JSONViewModel()
    let from : String
    let txAmt : Double
    let fee : Double

    // MARK: - BODY
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment:.leading){
                // Order place
                Text("\(from)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                // Order type
                Text( "-$" + String(round(fee * 100) / 100))
                    .foregroundColor(.red)
                    .font(.system(size: 10,design: .rounded).weight(.light))

                
            } //: VSTACK
            Spacer(minLength: 120)
            VStack{
                Text("+$" + String(round(txAmt * 100) / 100))
                    .font(.system(size: 20,design: .rounded).weight(.bold))
                    .foregroundColor(.green)
            }
            .padding()
            
            Spacer(minLength: 0)
        }
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(red: 255, green: 245, blue: 158))
                .frame(width: 350, height:70)
                .shadow(radius: 10)

        )
    }
}

struct OrderCell_Previews: PreviewProvider {
    static var previews: some View {
        txCell(from: "Akhil", txAmt: 12, fee: 0)
    }
}
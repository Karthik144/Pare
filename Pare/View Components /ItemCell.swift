//
//  ItemCell.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI
import Kingfisher

struct ItemCell: View {

    // MARK: - PROPERTIES
    let item: MenuItem

    // MARK: - BODY
    var body: some View {


        HStack{

            KFImage(URL(string: item.image))
                .resizable()
                .frame(width: 85, height: 80)
                .scaledToFit()
                .cornerRadius(5)
                .padding()


            Spacer()

            VStack(alignment: .leading){

                Text(item.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .lineLimit(1)

                Text(item.description)
                    .multilineTextAlignment(.leading)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)



                HStack{

//                    Text(String(item.price) + " USDC")
//                        .font(.callout)
//                        .foregroundColor(Color.black)

                    Text("\(String(describing: try? item.price)) USDC")
                        .font(.callout)
                        .foregroundColor(Color.black)


                    HStack{
                        Image("GlowingStar")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .scaledToFit()

                        Text(item.rewards + " rewards")
                            .font(.callout)
                            .foregroundColor(Color.black)
                            .lineLimit(1)
                    } //: HSTACK
                    .padding(.leading, 5)


                } //: HSTACK


            } //: VSTACK
//            .padding()
//            .padding(.top, 0)
//            .padding(.bottom, 0)

            Spacer()

        } //: HSTACK
    }
}

//struct ItemCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemCell()
//    }
//}

//
//  ShopItemView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct ShopItemView: View {

    // MARK: - PROPERTIES
    let shop: Shop


    // MARK: - BODY 
    var body: some View {
        
        if #available(iOS 16.0, *) {
            VStack{

                HStack{

                    Image("OttoStore")
                        .resizable()
                        .frame(width: 115, height: 115)
                        .scaledToFit()
                        .cornerRadius(7)

                    VStack(alignment: .leading){



                        Text(shop.name)
                            .font(.title3)
                            .fontWeight(.bold)

                        HStack{

                            Text(shop.type)
                                .foregroundColor(Color.gray)

                            Circle()
                                .foregroundColor(Color.gray)
                                .frame(width: 2, height: 2)

                            Text("Turkish")
                                .foregroundColor(Color.gray)

                            Circle()
                                .foregroundColor(Color.gray)
                                .frame(width: 2, height: 2)

                            HStack{
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.black)
                                Text("4.86")
                                    .foregroundColor(Color.black)
                            } //: HStack



                        }//: HStack

                        Text("Open Now")
                            .foregroundColor(Color.green)


                    } //: VSTACK
                    .padding(.leading, 5)


                } //: HSTACK
                .padding()

                ScrollView {

                    HStack{
                        Text("Bowls")
                            .fontWeight(.bold)
                            .font(.title3)
                        Spacer()
                    } //: HSTACK
                    .padding(.leading, 20)
                    .padding(.bottom, 0)


                    VStack{
                        ForEach((0...1), id: \.self) {_ in

                            NavigationLink(destination: AddItemView()
                            ) {
                                ItemCell()
                                    .padding(.leading, 0)
                                    .padding()
                            }


                        } //: FOR EACH
                    } //: VSTACK


                    HStack{
                        Text("Wraps")
                            .fontWeight(.bold)
                            .font(.title3)
                        Spacer()
                    } //: HSTACK
                    .padding(.leading, 20)
                    .padding(.bottom, 0)

                    VStack{

                        ForEach((0...3), id: \.self) {_ in

                            NavigationLink(destination: AddItemView()) {
                                ItemCell()
                                    .padding(.leading, 0)
                                    .padding()
                            }


                        } //: FOR EACH


                    } //: VSTACK


                } //: SCROLL VIEW


            } //: VSTACK
            .toolbar(.hidden, for: .tabBar)
        } else {
            // Fallback on earlier versions
        }


    }

    
}

//struct ShopItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopItemView()
//    }
//}

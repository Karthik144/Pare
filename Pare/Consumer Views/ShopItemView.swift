//
//  ShopItemView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI
import Kingfisher

struct ShopItemView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: ShopViewModel
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var totalMenuItems = [MenuItem]()
    @State private var appetizers = [MenuItem]()
    @State private var entrees = [MenuItem]()
    @State private var vegetarian = [MenuItem]()
    @State private var total = 0.0
    @State private var totalRewards = 0.0

    @Binding var rootIsActive: Bool 
    
    let shop: Shop

    // MARK: - BODY 
    var body: some View {
        
        if #available(iOS 16.0, *) {
            VStack{

                HStack{



                    KFImage(URL(string: shop.image))
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

                            Text(shop.cuisine)
                                .foregroundColor(Color.gray)

                            Circle()
                                .foregroundColor(Color.gray)
                                .frame(width: 2, height: 2)

                            HStack{
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.black)
                                Text(shop.rating)
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

                    if appetizers.count >= 1 {

                        HStack{
                            Text("Appetizers")
                                .fontWeight(.bold)
                                .font(.title3)
                            Spacer()
                        } //: HSTACK
                        .padding(.leading, 20)
                        .padding(.bottom, 0)

                        VStack(alignment: .leading){
                            ForEach(appetizers) { item in

                                NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                ) {
                                    ItemCell(item: item)
                                        .padding(.leading, 15)
                                        .padding(.trailing, 15)
                                }


                            } //: FOR EACH
                        } //: VSTACK

                    }

                    if vegetarian.count >= 1 {

                        HStack{
                            Text("Vegetarian")
                                .fontWeight(.bold)
                                .font(.title3)
                            Spacer()
                        } //: HSTACK
                        .padding(.leading, 20)
                        .padding(.bottom, 0)

                        VStack(alignment: .leading){
                            ForEach(vegetarian) { item in

                                NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                ) {
                                    ItemCell(item: item)
                                        .padding(.leading, 15)
                                        .padding(.trailing, 15)
                                }


                            } //: FOR EACH
                        } //: VSTACK

                    }

                    if entrees.count >= 1 {

                        HStack{
                            Text("Entrees")
                                .fontWeight(.bold)
                                .font(.title3)
                            Spacer()
                        } //: HSTACK
                        .padding(.leading, 20)
                        .padding(.bottom, 0)

                        VStack(alignment: .leading){
                            ForEach(entrees) { item in

                                NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                ) {
                                    ItemCell(item: item)
                                        .padding(.leading, 15)
                                        .padding(.trailing, 15)
                                }


                            } //: FOR EACH
                        } //: VSTACK
                    }

//                    HStack{
//                        Text("Menu")
//                            .fontWeight(.bold)
//                            .font(.title3)
//                        Spacer()
//                    } //: HSTACK
//                    .padding(.leading, 20)
//                    .padding(.bottom, 0)


//                    VStack(alignment: .leading){
//                        ForEach(totalMenuItems) { item in
//
//                            NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
//                            ) {
//                                ItemCell(item: item)
//                                    .padding(.leading, 15)
//                                    .padding(.trailing, 15)
//                            }
//
//
//                        } //: FOR EACH
//                    } //: VSTACK


                } //: SCROLL VIEW


                if authViewModel.currentUser?.cart_active == true {

                    
                    NavigationLink {
                        CheckoutView(shop: shop, rootActive: $rootIsActive)
                    } label: {

                        HStack{

                            Text("Checkout")
                                .foregroundColor(Color.white)
                                .padding(.leading,10)

                            Spacer()


                            HStack{

                                Text(String(total) + " USDC")
                                    .foregroundColor(Color.white)

                                Text("+\(totalRewards) 🌟")
                                    .foregroundColor(Color.white)

                            }
                            .padding()

                        }
                        .frame(width: 300, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: 300, height: 50)
                        )
                    }
                    .padding()
                    .padding(.bottom, 20)


                } //: IF STATEMENT

            } //: VSTACK
            .toolbar(.hidden, for: .tabBar)
            .onAppear(){

                viewModel.fetchShopMenu(withUID: shop.id ?? "") { menuItems in
                    self.totalMenuItems = menuItems

                    for each in totalMenuItems{

                        if each.type.contains("Veg"){
                            vegetarian.append(each)
                        }

                        else if each.type.contains("Appetizer"){

                            appetizers.append(each)
                        }

                        else {

                            entrees.append(each)
                        }
                    }
                }

                total = viewModel.calcTotal()

                totalRewards = viewModel.calcTotalRewards()

                print("ON APPEAR")
                print(rootIsActive)

            } //: ON APPEAR 



        } else {
            // Fallback on earlier versions
        }


    } //: VIEW

}

//struct ShopItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopItemView()
//    }
//}
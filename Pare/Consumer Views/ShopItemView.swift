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
    @State private var appearTotal = 0
    @State private var isAppExpanded = false
    @State private var isVegExpanded = false
    @State private var isEntreeExpanded = false
    let currentDate = Date()
    let calendar = Calendar.current
    @State var dayOfWeek: Int?





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
                        if ((dayOfWeek ?? 0) == 7){
                            Text("Closed")
                                .foregroundColor(Color.red)
                        }
                        else{
                            Text("Open Now")
                                .foregroundColor(Color.green)
                        }

                    } //: VSTACK
                    .padding(.leading, 5)

                    Spacer()


                } //: HSTACK
                .padding()

                ScrollView {

                    if appetizers.count >= 1 {

                        DisclosureGroup {
                            VStack(alignment: .leading){
                                ForEach(appetizers) { item in

                                    NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                    ) {
                                        ItemCell(item: item)

                                    }


                                } //: FOR EACH
                            } //: VSTACK
                        } label: {
                            HStack{

                                Image("appetizer")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)

                                Text("Appetizer")

                            }
                        }
                        .accentColor(Color.black)
                        .fontWeight(.medium)
                        .font(.title3)
                        .padding()


                    }

                    if vegetarian.count >= 1 {

                        DisclosureGroup {

                            VStack(alignment: .leading){
                                ForEach(vegetarian) { item in

                                    NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                    ) {
                                        ItemCell(item: item)
                                    }


                                } //: FOR EACH
                            } //: VSTACK

                        } label: {

                            HStack{

                                Image("veg")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)

                                Text("Vegetarian")

                            }

                        }
                        .accentColor(Color.black)
                        .fontWeight(.medium)
                        .font(.title3)
                        .padding()

                    }

                    if entrees.count >= 1 {

                        DisclosureGroup {

                            VStack(alignment: .leading){
                                ForEach(entrees) { item in

                                    NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                    ) {
                                        ItemCell(item: item)
//                                            .padding(.leading, 15)
//                                            .padding(.trailing, 15)
                                    }


                                } //: FOR EACH
                            } //: VSTACK

                        } label: {

                            HStack{

                                Image("entree")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)

                                Text("Entrees")

                            }

                        }
                        .accentColor(Color.black)
                        .fontWeight(.medium)
                        .font(.title3)
                        .padding()
                    }


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

                                Text("+\(String(viewModel.totalRewards)) 🌟")
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
                dayOfWeek = calendar.component(.weekday, from: currentDate)
                if appearTotal<1{

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

                    appearTotal += 1

                }

            } //: ON APPEAR 



        } else {
            // Fallback on earlier versions

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

                    Spacer()


                } //: HSTACK
                .padding()

                ScrollView {

                    if appetizers.count >= 1 {

                        DisclosureGroup {
                            VStack(alignment: .leading){
                                ForEach(appetizers) { item in

                                    NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                    ) {
                                        ItemCell(item: item)

                                    }


                                } //: FOR EACH
                            } //: VSTACK
                        } label: {
                            HStack{

                                Image("appetizer")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)

                                Text("Appetizer")

                            }
                        }
                        .accentColor(Color.black)
                        .font(.title3)
                        .padding()


                    }

                    if vegetarian.count >= 1 {

                        DisclosureGroup {

                            VStack(alignment: .leading){
                                ForEach(vegetarian) { item in

                                    NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                    ) {
                                        ItemCell(item: item)
                                    }


                                } //: FOR EACH
                            } //: VSTACK

                        } label: {

                            HStack{

                                Image("veg")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)

                                Text("Vegetarian")

                            }

                        }
                        .accentColor(Color.black)
                        .font(.title3)
                        .padding()

                    }

                    if entrees.count >= 1 {

                        DisclosureGroup {

                            VStack(alignment: .leading){
                                ForEach(entrees) { item in

                                    NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                    ) {
                                        ItemCell(item: item)
//                                            .padding(.leading, 15)
//                                            .padding(.trailing, 15)
                                    }


                                } //: FOR EACH
                            } //: VSTACK

                        } label: {

                            HStack{

                                Image("entree")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)

                                Text("Entrees")

                            }

                        }
                        .accentColor(Color.black)
                        .font(.title3)
                        .padding()
                    }


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

                                Text("+\(String(viewModel.totalRewards)) 🌟")
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
            .onAppear(){
                if appearTotal<1{

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

                    appearTotal += 1

                }

            } //: ON APPEAR
        }


    } //: VIEW

}

//struct ShopItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopItemView()
//    }
//}

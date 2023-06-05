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
    @EnvironmentObject var walletViewModel: WalletViewModel
    @StateObject var magicSingleton = MagicSingleton.shared

    @State private var totalMenuItems = [MenuItem]()
    @State private var appetizers = [MenuItem]()
    @State private var entrees = [MenuItem]()
    @State private var vegetarian = [MenuItem]()
    @State private var lunch = [MenuItem]()
    @State private var total = 0.0
    //    @Binding var total: Double
    @State private var totalRewards = 0.0
    @State private var appearTotal = 0
    @State private var isAppExpanded = false
    @State private var isVegExpanded = false
    @State private var isEntreeExpanded = false
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    @State var date: String?
    @State var dayOfWeek: Int?
    var closingTime = "22:00"
    var openingTime = "11:00"
    var sundayOpen = "12:00"


    @Binding var rootIsActive: Bool
    
    let shop: Shop

    // MARK: - BODY
    var body: some View {


        if #available(iOS 16.0, *){

            VStack{

                HStack{

                    KFImage(URL(string: shop.image))
                        .resizable()
                        .frame(width: 115, height: 115)
                        .scaledToFit()
                        .cornerRadius(7)


                    VStack(alignment: .leading){

                        Text(shop.name)
                            .font(.title3.weight(.bold))

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

                        // Shop status - Closed or Open Now
                        VStack{
                            if((dayOfWeek ?? 0) == 7 || (date ?? "" > closingTime) || (date ?? "" < openingTime) ){
                                Text("Closed")
                                    .foregroundColor(Color.red)
                            }
                            else if((dayOfWeek ?? 0) == 1 && (date ?? "" > closingTime) && (date ?? "" < sundayOpen) ){
                                Text("Closed")
                                    .foregroundColor(Color.red)
                            }
                            else{
                                Text("Open Now")
                                    .foregroundColor(Color.green)
                            }
                        }//:VStack

                    } //: VSTACK
                    .padding(.leading, 5)

                    Spacer()


                } //: HSTACK
                .padding()

                ScrollView {


                    // Appetizers drop down
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
                        .font(.title3.weight(.medium))
                        .padding()
                    } //: APPETIZER DROP DOWN

                    // Vegetarian drop down
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
                        .font(.title3.weight(.medium))
                        .padding()

                    }//: VEG DROP DOWN

                    // Main entrees drop down
                    if entrees.count >= 1 {

                        DisclosureGroup {

                            VStack(alignment: .leading){
                                ForEach(entrees) { item in

                                    NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                    ) {
                                        ItemCell(item: item)
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
                        .font(.title3.weight(.medium))
                        .padding()
                    } //: ENTREES DROP DOWN

                    // Show Lunch Special for Sunday, 12-4pm OR Lunch Special for Mon-Fri, 11-4pm
                    if checkIfLunchSpecialValid(){

                        if lunch.count >= 1 {

                            DisclosureGroup {

                                VStack(alignment: .leading){
                                    ForEach(lunch) { item in

                                        NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                        ) {
                                            ItemCell(item: item)
                                        }

                                    } //: FOR EACH
                                } //: VSTACK

                            } label: {

                                HStack{

                                    Image("GlowingStar")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)

                                    Text("Lunch Specials")

                                }

                            }
                            .accentColor(Color.black)
                            .font(.title3.weight(.medium))
                            .padding()
                        }

                    } //: ONLY SHOW DROP DOWN IF LUNCH SPECIAL HOURS

                    Spacer()


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

                                let displayTotal = String(format: "%.2f", roundToTwoDecimalPlaces(viewModel.total))
                                Text("\(displayTotal) USDC")
                                    .foregroundColor(Color.white)

                                let displayRewardTotal = String(format: "%.2f", roundToTwoDecimalPlaces(viewModel.totalRewards))

                                Text("+\(displayRewardTotal) 🌟")
                                    .foregroundColor(Color.white)

                            }
                            .padding()
                            .onAppear{
                                print("TEST ROUND",roundToTwoDecimalPlaces(viewModel.total))
                            }

                        }
                        .frame(width: 345, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: 345, height: 50)
                        )
                    }
                    .padding()
                    .padding(.bottom, 20)


                } //: IF STATEMENT

            } //: VSTACK
            .toolbar(.hidden, for: .tabBar)
            .onAppear(){
                dateFormatter.dateFormat = "HH:mm"
                date = dateFormatter.string(from: Date())
                dayOfWeek = calendar.component(.weekday, from: Date())

                let displayTotal = roundToTwoDecimalPlaces(viewModel.total)

                if appearTotal == 0 {

                    viewModel.fetchShopMenu(withUID: shop.id ?? "") { menuItems in
                        self.totalMenuItems = menuItems

                        for each in totalMenuItems{

                            if each.type.contains("Veg"){
                                vegetarian.append(each)
                            }

                            else if each.type.contains("Appetizer"){

                                appetizers.append(each)
                            }

                            else if each.type.contains("lunch"){

                                lunch.append(each)
                            }

                            else{
                                entrees.append(each)
                            }
                        }
                    }

                    total = viewModel.calcTotal()

                    totalRewards = viewModel.calcTotalRewards()

                    appearTotal += 1

                } //: IF APPEAR = 0


                walletViewModel.getBalance(magic: magicSingleton.magic, userPublicAddress: authViewModel.currentUser?.public_address ?? "") { balance in

                    if let balance = balance {
                        print("\(balance) - ShopItemView")

                    } else {
                        print("Error retrieving balance. - ShopsView")
                    }
                }

                

            } //: ON APPEAR




        } else {


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

                        // Shop status - Closed or Open Now
                        VStack{
                            if((dayOfWeek ?? 0) == 7 || (date ?? "" > closingTime) || (date ?? "" < openingTime) ){
                                Text("Closed")
                                    .foregroundColor(Color.red)
                            }
                            else if((dayOfWeek ?? 0) == 1 && (date ?? "" > closingTime) && (date ?? "" < sundayOpen) ){
                                Text("Closed")
                                    .foregroundColor(Color.red)
                            }
                            else{
                                Text("Open Now")
                                    .foregroundColor(Color.green)
                            }
                        }//:VStack

                    } //: VSTACK
                    .padding(.leading, 5)

                    Spacer()


                } //: HSTACK
                .padding()

                ScrollView {


                    // Appetizers drop down
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
                        .font(.title3.weight(.medium))
                        .padding()
                    } //: APPETIZER DROP DOWN

                    // Vegetarian drop down
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
                        .font(.title3.weight(.medium))
                        .padding()

                    }//: VEG DROP DOWN

                    // Main entrees drop down
                    if entrees.count >= 1 {

                        DisclosureGroup {

                            VStack(alignment: .leading){
                                ForEach(entrees) { item in

                                    NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                    ) {
                                        ItemCell(item: item)
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
                        .font(.title3.weight(.medium))
                        .padding()
                    } //: ENTREES DROP DOWN

                    // Show Lunch Special for Sunday, 12-4pm OR Lunch Special for Mon-Fri, 11-4pm
                    if checkIfLunchSpecialValid(){

                        if lunch.count >= 1 {

                            DisclosureGroup {

                                VStack(alignment: .leading){
                                    ForEach(lunch) { item in

                                        NavigationLink(destination: AddItemView(order: Order(item: item), shop: shop, rootIsStillActive: $rootIsActive)
                                        ) {
                                            ItemCell(item: item)
                                        }

                                    } //: FOR EACH
                                } //: VSTACK

                            } label: {

                                HStack{

                                    Image("GlowingStar")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)

                                    Text("Lunch Specials")

                                }

                            }
                            .accentColor(Color.black)
                            .font(.title3.weight(.medium))
                            .padding()
                        }

                    } //: ONLY SHOW DROP DOWN IF LUNCH SPECIAL HOURS

                    Spacer()


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

                                let displayTotal = String(format: "%.2f", roundToTwoDecimalPlaces(viewModel.total))
                                Text("\(displayTotal) USDC")
                                    .foregroundColor(Color.white)

                                let displayRewardTotal = String(format: "%.2f", roundToTwoDecimalPlaces(viewModel.totalRewards))
                                Text("+\(displayRewardTotal) 🌟")
                                    .foregroundColor(Color.white)

                            }
                            .padding()
                            .onAppear{
                                print("TEST ROUND",roundToTwoDecimalPlaces(viewModel.total))
                            }

                        }
                        .frame(width: 345, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: 345, height: 50)
                        )
                    }
                    .padding()
                    .padding(.bottom, 20)


                } //: IF STATEMENT

            } //: VSTACK
            .onAppear(){
                dateFormatter.dateFormat = "HH:mm"
                date = dateFormatter.string(from: Date())
                dayOfWeek = calendar.component(.weekday, from: Date())

                let displayTotal = roundToTwoDecimalPlaces(viewModel.total)

                if appearTotal == 0 {

                    viewModel.fetchShopMenu(withUID: shop.id ?? "") { menuItems in
                        self.totalMenuItems = menuItems

                        for each in totalMenuItems{

                            if each.type.contains("Veg"){
                                vegetarian.append(each)
                            }

                            else if each.type.contains("Appetizer"){

                                appetizers.append(each)
                            }

                            else if each.type.contains("lunch"){

                                lunch.append(each)
                            }

                            else{
                                entrees.append(each)
                            }
                        }
                    }

                    total = viewModel.calcTotal()

                    totalRewards = viewModel.calcTotalRewards()

                    appearTotal += 1

                } //: IF APPEAR = 0

            } //: ON APPEAR

        } //: ELSE





    } //: VIEW


    func checkIfLunchSpecialValid() -> Bool{

        guard let dayOfWeek = dayOfWeek else {
            print("ERROR: dayOfWeek is nil - checkIfLunchSpecialValid, ShopItemView")
            return false
        }

        guard let date = date else {
            print("ERROR: date is nil - checkIfLunchSpecialValid, ShopItemView")
            return false
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: Date())

        // Check if it's Sunday between 12-4pm or Monday to Friday between 11-4pm
        if (dayOfWeek == 1 && currentTime >= "12:00" && currentTime <= "16:00") ||
            (dayOfWeek > 1 && dayOfWeek < 7 && currentTime >= "11:00" && currentTime <= "16:00") {

            return true
        }

        return false

    } //: FUNC CHECK IF LUNCH SPECIAL VALID

    func roundToTwoDecimalPlaces(_ number: Double) -> Double {
        let decimalPlaces = 2
        let multiplier = pow(10.0, Double(decimalPlaces))
        return round(number * multiplier) / multiplier
    }


}


//struct ShopItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopItemView()
//    }
//}

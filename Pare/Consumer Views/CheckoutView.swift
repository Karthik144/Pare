//
//  CheckoutView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI
import Kingfisher
import MagicSDK_Web3
import StripePaymentSheet

struct CheckoutView: View {

    // MARK: - PROPERTIES
    let shop: Shop
    @State var total = 0.0
    @State var subtotal = 0.0
    @State var tax = 0.0
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var viewModel: ShopViewModel
    @EnvironmentObject var walletViewModel: WalletViewModel
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var sheetManager: SheetManager
    @EnvironmentObject var promoSheetManager: PromoSheetManager
    @StateObject var magicSingleton = MagicSingleton.shared

    @State private var showingAlert = false
    @State private var showingBalanceAlert = false
    @State private var showingWalletAlert = false

    @State var noteText = ""
    @State var promoText = ""
    @State var rewards = false
    @State var promoCodeIsValid = false
    @State var promoUsed = false
    @Binding var rootActive: Bool
    @State var rootIsActive = false
    @State private var isActionComplete = false

    private static let backendURL = URL(string: "https://pareapp-stripe.glitch.me")!

    @State private var paymentIntentClientSecret: String?
    @State private var showAlert = false


    // MARK: - BODY
    var body: some View {

        VStack{

            Spacer()

            VStack(alignment: .leading){

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

                        Text(shop.address)
                            .foregroundColor(Color.gray)

                        Text("Pickup")
                            .foregroundColor(Color.green)


                    } //: VSTACK
                    .padding(.leading, 5)

                } //: HSTACK
                .padding()
                .padding(.top, 50)


                HStack{

                    Text("Your Order")
                        .font(.title3)
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .padding(.leading, 20)


                    Spacer()

                    Button {

                        // Show popup with textfield
                        sheetManager.present()


                    } label: {


                        Text("Add Note")
                            .frame(width: 100, height: 25)
                            .foregroundColor(Color.accentColor)
                            .overlay(

                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )

                    }
                    .padding()


                }
            } //: VSTACK
            .padding(.top, 40)


            ScrollView{

                ForEach(viewModel.cartItems) { order in


                    let index = viewModel.cartItems.firstIndex(of: order)
                    let itemPrice = Double(order.item.price)! + Double(order.getAddOns())!


                    OrderItemCell(itemQuantity: order.item.quantity!, itemName: order.item.name, itemPrice: order.item.price, rewardPoints: order.item.rewards, index: index!, popup:false, finalTotal: total)
                        .padding(.leading, 25)
                        .padding(.trailing, 20)
                        .onAppear{
                            order.item.price = String(itemPrice)
                        }
                        .onAppear(){
                            let index = viewModel.cartItems.firstIndex(of: order)
                        }

                } //: FOR EACH


                HStack{

                    Spacer()

                    Button {

                        // Show popup with promo code text field
                        promoSheetManager.present()


                    } label: {

                        Text("Add Promo Code")
                            .frame(width: 140, height: 25)
                            .foregroundColor(Color.accentColor)
                            .overlay(

                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )

                    } //: BUTTON
                    .frame(width: 140, height: 25)
                    .padding()

                } //: HSTACK



                Divider()

                HStack{

                    Text("Subtotal")

                    Spacer()

                    if self.promoCodeIsValid && viewModel.cartItems.count == 1 {
                        Text(String("0 USD"))
                    } else {
                        Text(String(round(viewModel.subtotal * 100) / 100.0) + " USD")
                    }


                } //: HSTACK
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 10)

                HStack{

                    Text("Tax")

                    Spacer()

                    if self.promoCodeIsValid && viewModel.cartItems.count == 1 {
                        Text(String("0 USD"))
                    } else {
                        Text(String(viewModel.tax) + " USD")
                    }

                } //: HSTACK
                .padding(.leading, 20)
                .padding(.trailing, 20)


                Divider()


                HStack{

                    Text("Total")

                    Spacer()

                    let displayTotal = roundToThreeDecimalPlaces(viewModel.total)

                    if self.promoCodeIsValid && viewModel.cartItems.count == 1 {

                        Text(String("0 USD"))

                    } else {

                        Text(String(displayTotal) + " USD")
                    }

                } //: HSTACK
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)



                HStack{

                    Text("Rewards Earned")

                    Spacer()

                    let displayRewardsTotal = roundToThreeDecimalPlaces(viewModel.totalRewards)

                    Text(String(displayRewardsTotal) + " 🌟")

                } //: HSTACK
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.leading, 20)
                .padding(.trailing, 20)


                Spacer()


                VStack(spacing: 30){
                    /*
                    if authViewModel.currentUser?.wallet == false {

                        Button {
                            showingWalletAlert = true
                        } label: {
                            Text("Pay")
                                .foregroundColor(Color.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                        .fill(Color.accentColor)
                                        .frame(width: 300, height: 50)
                                )
                        }
                        .alert("You haven't set up your wallet yet. Go to the Wallet Tab to finish setup.", isPresented: $showingWalletAlert) {
                            Button("Ok", role: .cancel) { }
                        }

                    } else { */
                        NavigationLink(isActive: $rootIsActive) {
                            StripePayView(isActive: $rootActive, noteText: noteText, shop: shop, promoUsed: promoUsed)
                        } label: {
                            
                            Button {
                                startCheckout { clientSecret in

                                    PaymentConfig.shared.paymentIntentClientSecret = clientSecret

                                    print("Button pressed")

                                    print(clientSecret ?? "Error")

                                    DispatchQueue.main.async {
                                        rootIsActive = true
                                    }

                                }
                                /*
                                 Web3 Shit
                                // User public address
                                let publicAddress = authViewModel.currentUser?.public_address
                                let magic = magicSingleton.magic
                                
                                
                                if Double(walletViewModel.userTokenBalance) >= viewModel.total{
                                    
                                    let conversionFactor = 1_000_000
                                    let convertedValue = BigUInt(viewModel.total * Double(conversionFactor))
                                    
                                    // Send USD to restaurant
                                    walletViewModel.sendTransaction(magic: magic, userPublicAddress: publicAddress ?? "", amount: convertedValue)
                                    
                                    // Send order to restaurant
                                    completeOrder()
                                    
                                } else {
                                    
                                    showingBalanceAlert = true
                                    
                                }
                                 */
                                
                                
                            } label: {
                                Text("Pay")
                                    .foregroundColor(Color.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                            .fill(Color.accentColor)
                                            .frame(width: 300, height: 50)
                                    )
                            }
                            .frame(width: 300, height: 50)
                            .alert("Not enough USD in wallet!", isPresented: $showingBalanceAlert) {
                                Button("Ok", role: .cancel) { }
                            }
                        }

                    //} //: ELSE



                    Button {

                        // Change cart active status
                        viewModel.updateCartActiveStatus(cartActive: false)

                        // Store users rewards
                        var userRewards = Double(authViewModel.currentUser?.rewards ?? 0.0)


                        if userRewards >= viewModel.total{

                            // Subtract used rewards from new rewards and update it to total rewards
                            let extraRewards = userRewards - viewModel.total

                            let updatedRewards = (viewModel.totalRewards) + extraRewards

                            // Update user's rewards with new rewards from purchase
                            viewModel.updateRewards(rewards: Double(updatedRewards))

                            rewards = true

                            // Upload order to Firebase (so shop can access it)
                            viewModel.postOrderData(shop: shop, cartTotalItems: String(viewModel.cartItems.count), cart: viewModel.cartItems, orderStatus: "pending", subtotal: viewModel.subtotal, total: viewModel.total, user: authViewModel.currentUser!, rewards: rewards, notes: noteText, promo_used: self.promoUsed)

                            //Empty out cart
                            viewModel.cartItems = []

                            //Pop to Shop View
                            rootActive = false

                        } else {
                            showingAlert = true
                            /*
                            // Subtract total from rewards to get new price
                            // 5.67 - 1 = 4.67
                            let newTotal = viewModel.total - userRewards
                            let newSubTotal = viewModel.subtotal - userRewards

                            // new total: 4.67
                            viewModel.total = newTotal


                            viewModel.totalRewards = (newSubTotal) * 0.10

                            // 0.10 x 4.67 = 0.467
                            // Update user's rewards with new rewards from purchase
                            viewModel.updateRewards(rewards: Double(viewModel.totalRewards))

                            rewards = true
                             */
                        }
                      
                    } label: {
                        Text("Pay with stars 🌟")
                            .frame(width: 300, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )
                    }
                    .alert("Not enough rewards!", isPresented: $showingAlert) {
                        Button("Ok", role: .cancel) { }
                    }


//                    Button("Checkout"){
//                        startCheckout { clientSecret in
//
//                            PaymentConfig.shared.paymentIntentClientSecret = clientSecret
//
//
//                            print(clientSecret)
//
//                        }
//                    }

//                    NavigationLink(destination: StripePayView(), isActive: $rootActive) {
//                        Button {
//                            startCheckout { clientSecret in
//                                PaymentConfig.shared.paymentIntentClientSecret = clientSecret
//                                print("Button pressed")
//                                print(clientSecret ?? "Error")
//                                DispatchQueue.main.async {
//                                    isActionComplete = true
//                                }
//                            }
//                        } label: {
//                            Text("Checkout")
//                                .foregroundColor(Color.accentColor)
//                        }
//                    }

                    /*

                    NavigationLink(isActive: $rootIsActive) {
                        StripePayView(isActive: $rootActive, noteText: noteText, shop: shop, promoUsed: promoUsed)
                    } label: {

                        Button("Checkout"){
                            startCheckout { clientSecret in

                                PaymentConfig.shared.paymentIntentClientSecret = clientSecret

                                print("Button pressed")

                                print(clientSecret ?? "Error")

                                DispatchQueue.main.async {
                                    rootIsActive = true
                                }

                            }
                        }

                    }
                     */


                } //: VSTACK
                .padding()



            } //: SCROLL VIEW


        } //: VSTACK
        .onAppear(){
            total = viewModel.calcTotal()
            viewModel.totalRewards = viewModel.calcTotalRewards()
            
        }
        .overlay(alignment: .bottom){

            if sheetManager.action.isPresented {
                PopUpView(text: $noteText, title: "Add a note", subTitle: "Mention any dietary restrictions, additional modifications, or just say thanks!", promoCodePopup: false){

                    withAnimation {
                        sheetManager.dismiss()
                    }
                }
            } //: IF SHEET MANAGER PRESENTED

            if promoSheetManager.action.isPresented {

                PopUpView(text: $promoText, title: "Add a promo code", subTitle: "Enter FREE for a meal on us! Please make sure you have only one item in the cart.", promoCodePopup: true) {
                    withAnimation {
                        promoSheetManager.dismiss()
                    }

                    self.promoCodeIsValid = self.verifyPromoCode(promoCode: promoText)

                    if self.promoCodeIsValid{

                        self.promoUsed = true
                    }

                }
            } //: IF PROMO SHEET MANAGER PRESENTED


        }
        .ignoresSafeArea()


    } //: VIEW

    func roundToThreeDecimalPlaces(_ number: Double) -> Double {

        let decimalPlaces = 3
        let multiplier = pow(10.0, Double(decimalPlaces))
        return round(number * multiplier) / multiplier

    } //: FUNC ROUND

    func verifyPromoCode(promoCode: String) -> Bool {

        // Requirements:
        // 1. wallet needs to be set up with funds
        // 2. promo code must be valid
        // 3. promo code must not have already been used

        if authViewModel.currentUser?.wallet == true && promoCode == "FREE" && authViewModel.currentUser?.used_promo_code == false {
            return true
        } else {
            return false
        }
    } //: FUNC VERIFY PROMO CODE

    func completeOrder(){

        // Change cart active status
        viewModel.updateCartActiveStatus(cartActive: false)

        // Store users rewards
        let userRewards = Double(authViewModel.currentUser?.rewards ?? 0.0)

        if rewards != true {
            // Find new total rewards from purchase
            let totalFinalRewards = userRewards + viewModel.totalRewards

            // Update rewarads in firebase
            viewModel.updateRewards(rewards: totalFinalRewards)
        }

        // Upload order to Firebase (so shop can access it)
        viewModel.postOrderData(shop: shop, cartTotalItems: String(viewModel.cartItems.count), cart: viewModel.cartItems, orderStatus: "pending", subtotal: viewModel.subtotal, total: viewModel.total, user: authViewModel.currentUser!, rewards: rewards, notes: noteText, promo_used: promoUsed)


        //Empty out cart
        viewModel.cartItems = []

        //Pop to Shop View
        rootActive = false

    }

    private func startCheckout(completion: @escaping (String?) -> Void){

        //let url = URL(string: "http://localhost:4242/create-payment-intent")!
        let url = URL(string: "https://pareapp-stripe.glitch.me/create-payment-intent")!

        
        var shoppingCartContent: [String: Any] = [
            "items": []
        ]
        
        for order in viewModel.cartItems {
            if var items = shoppingCartContent["items"] as? [[String: Any]] {
                var priceCents = (Double(order.item.price) ?? 0.0) * 100
                items.append(["id": order.item.id, "price": Int(priceCents)])
                shoppingCartContent["items"] = items
            }
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: shoppingCartContent)


        URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200

            else {
                completion(nil)
                return
            }

            let checkoutIntentResponse = try? JSONDecoder().decode(CheckoutIntentResponse.self, from: data)

            completion(checkoutIntentResponse?.clientSecret)

        }.resume()
    }

    func showAlert(title: String, message: String? = nil) {
        self.showAlert = true
    }

}


// MARK: - PREVIEW 
//struct CheckoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckoutView()
//    }
//}

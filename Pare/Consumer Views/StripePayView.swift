//
//  StripePayView.swift
//  Pare
//
//  Created by Karthik  Ramu on 7/11/23.
//

import SwiftUI
import Stripe

struct StripePayView: View {

    @EnvironmentObject var viewModel: ShopViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var paymentMethodParams: STPPaymentMethodParams?
    @State private var message = ""
    @Binding var isActive: Bool
    let noteText: String
    let shop: Shop
    let promoUsed: Bool

    let paymentGatewayController = PaymentGatewayController()

    private func pay() {

        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else {
            return
        }

        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)


        paymentIntentParams.paymentMethodParams = paymentMethodParams

        paymentGatewayController.submitPayment(intent: paymentIntentParams) { status, intent, error in

            switch status {

            case .failed:
                message = "Payment failed. Please try again. If the issue persists, try using another card."

            case .canceled:
                message = "Payment cancelled. Please try again. If the issue persists, try using another card."

            case .succeeded:
                message="Success"
                completeOrder()
            }
        }



    }

    // MARK: - BODY
    var body: some View {

        VStack{


            // Stripe payment text field
            STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams)
                .padding()

            HStack{
                Text(message)
                    .font(.headline)
                    .foregroundColor(Color.red)
                    .padding()
                    .padding(.trailing, 0)
                    .padding(.top, 5)
                Spacer()
            }


            Spacer()


            // Pay button
            Button {

                pay()

            } label: {
                Text("Pay")
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 8,  style: .continuous)
                            .fill(Color.accentColor)
                            .frame(width: 300, height: 50)
                    )
            }
            .padding()
            .frame(width: 300, height: 50)


        } //: VSTACK
        .navigationTitle("Add your card")
        .navigationBarTitleDisplayMode(.large)

    } //: BODY VIEW

    func completeOrder(){

        // Change cart active status
        viewModel.updateCartActiveStatus(cartActive: false)

        // Store users rewards
        let userRewards = Double(authViewModel.currentUser?.rewards ?? 0.0)

        // Find new total rewards from purchase
        let totalFinalRewards = userRewards + viewModel.totalRewards

        // Update rewarads in firebase
        viewModel.updateRewards(rewards: totalFinalRewards)

        // Upload order to Firebase (so shop can access it)
        viewModel.postOrderData(shop: shop, cartTotalItems: String(viewModel.cartItems.count), cart: viewModel.cartItems, orderStatus: "pending", subtotal: viewModel.subtotal, total: viewModel.total, user: authViewModel.currentUser!, rewards: false, notes: noteText, promo_used: promoUsed)


        //Empty out cart
        viewModel.cartItems = []

        //Pop to Shop View
        isActive = false

    }


} //: VIEW

//
//struct StripePayView_Previews: PreviewProvider {
//    static var previews: some View {
//        StripePayView()
//    }
//}

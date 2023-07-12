//
//  StripePayView.swift
//  Pare
//
//  Created by Karthik  Ramu on 7/11/23.
//

import SwiftUI
import Stripe

struct StripePayView: View {

    @State var paymentMethodParams: STPPaymentMethodParams?
    @State private var message = ""
    //    @Binding var isActive: Bool

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

            }
        }



    }

    // MARK: - BODY
    var body: some View {

        VStack{


            // Stripe payment text field
            STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams)
                .padding()

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

            Text(message)
                .font(.headline)

        } //: VSTACK
        .navigationTitle("Add your card")
        .navigationBarTitleDisplayMode(.large)

    } //: BODY VIEW


} //: VIEW

//
//struct StripePayView_Previews: PreviewProvider {
//    static var previews: some View {
//        StripePayView()
//    }
//}

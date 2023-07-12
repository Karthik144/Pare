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
                    message = "failed"

                case .canceled:
                    message = "cancelled"

                case .succeeded:
                    message="Success"

            }
        }



    }

    // MARK: - BODY
    var body: some View {

        VStack{

            STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams)

            Button {
                pay()
            } label: {
                Text("Pay")
            }


            Text(message)
                .font(.headline)

        } //: VSTACK
        .onAppear(){

        }
    }
}
//
//struct StripePayView_Previews: PreviewProvider {
//    static var previews: some View {
//        StripePayView()
//    }
//}

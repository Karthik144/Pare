//
//  StripePayView.swift
//  Pare
//
//  Created by Karthik  Ramu on 7/11/23.
//

import SwiftUI
import Stripe

struct StripePayView: View {

    @State var loading = false
    @State var paymentMethodParams: STPPaymentMethodParams?


    // MARK: - BODY
    var body: some View {

        VStack{
            STPPaymentCardTextField.Representable(paymentMethodParams: $paymentMethodParams).padding() 

        } //: VSTACK
        .onAppear(){

        }
    }
}

struct StripePayView_Previews: PreviewProvider {
    static var previews: some View {
        StripePayView()
    }
}

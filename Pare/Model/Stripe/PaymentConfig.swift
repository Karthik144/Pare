//
//  PaymentConfig.swift
//  Pare
//
//  Created by Karthik  Ramu on 7/12/23.
//

import Foundation


class PaymentConfig {

    var paymentIntentClientSecret: String?
    static var shared: PaymentConfig = PaymentConfig()

    private init () {}
}

//
//  FundsView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/15/23.
//

import SwiftUI

struct FundsView: View {
    var data = getData()
    //get Firebase data for curr Fee
    var body: some View {
        //Implement Balance + Fees summary
        Text("balance: \(data.balance)")
        Text("fees\(data.from)")
            .onAppear{
                data.getBalance()
                data.getLastTransaction()
                data.getSender(signature: data.from)
            }
        
        //Implement tx ListView scrollable
        
    }
}

struct FundsView_Previews: PreviewProvider {
    static var previews: some View {
        FundsView()
    }
}

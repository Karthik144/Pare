//
//  FundsView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/15/23.
//

import SwiftUI

struct FundsView: View {
    @EnvironmentObject var viewModel : JSONViewModel
    var body: some View {
        //Implement Balance + Fees summary
        VStack{
            VStack{
                Text("$" + String(round(viewModel.balance * 100) / 100))
                    .font(.system(size: 80,design: .rounded).weight(.bold))
                    .foregroundColor(Color(red: 0.167, green: 0.29, blue: 0.933))
                Text("Fees: $" + String(round(viewModel.feeSum * 100) / 100))
            }
            .offset(y:50)
            .onAppear{
                viewModel.getSummary()
                //viewModel.checkTransaction()
                viewModel.getAPITransactions()
                if(viewModel.orderNum < viewModel.reqOrderNum){
                    viewModel.addTransaction()
                    viewModel.orderNum += 1
                }

            }
            Spacer()
            Text("Orders")
                .offset(y:-40)
                .font(.largeTitle)
            ScrollView{
                Spacer(minLength: 20)
                VStack(){
                    ForEach(viewModel.transactions){ transaction in
                        txCell(from: transaction.from, txAmt: transaction.txAmt, fee: transaction.fee)
                    }
                    .padding()
                }
            }
            .onAppear{
                viewModel.getTransactions()
            }
            .frame(width: 375,height: 400)
            .offset(y:-30)
        }
        
    }
}

struct FundsView_Previews: PreviewProvider {
    static var previews: some View {
        FundsView()
    }
}

//
//  FundsView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/15/23.
//

import SwiftUI

struct FundsView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel : JSONViewModel

    // MARK: - BODY
    var body: some View {

        NavigationView{

            //Implement Balance + Fees summary
            VStack{
                VStack{
                    Text("$" + String(round(viewModel.balance * 100) / 100.0))
                        .font(.system(size: 80,design: .rounded).weight(.bold))
                        .foregroundColor(Color(red: 0.167, green: 0.29, blue: 0.933))
//                    Text("Fees: $" + String(round(viewModel.feeSum * 100) / 100.0))
                    Text("Total Fees: $" + String(viewModel.balance * 0.01))

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

                HStack{

                    Text("Orders")
                        .font(.title2)
                        .padding()

                    Spacer()
                }
                .navigationTitle("Funds")

    //            Text("Orders")
    //                .offset(y:-40)
    //                .font(.largeTitle)
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
            } //: VSTACK


        } //: NAV VIEW

        
    }
}


// MARK: - PREVIEW
struct FundsView_Previews: PreviewProvider {
    static var previews: some View {
        FundsView()
    }
}

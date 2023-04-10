//
//  WalletView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct WalletView: View {
    
    @EnvironmentObject var viewModel: web3ViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.session == nil {
                Text("Connect to:")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                
                Button {
                    viewModel.connect(wallet: Wallets.TrustWallet)
                } label: {
                    HStack {
                        Spacer()
                        Text(Wallets.TrustWallet.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .cornerRadius(32)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 24)
                //metamask not working rn
                /*
                Button {
                    viewModel.connect(wallet: Wallets.Metamask)
                } label: {
                    HStack {
                        Spacer()
                        Text(Wallets.Metamask.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .cornerRadius(32)
                }
                .padding(.horizontal, 30)
                 */
                 
            } else {
                
                Text("Connected to \(viewModel.walletName)")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                
                Text("Address: \(viewModel.walletAccount ?? "")")
                    .font(.system(size: 13))
                    .fontWeight(.regular)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                
                if viewModel.isWrongChain {
                    Text("Connected to wrong chain. Please connect to Polygon")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.top, 30)
                } else {
                    Button {
                        let value = 1 * pow(10, 18)
                        viewModel.sendTx(to: "0xA741b63997bbF5AaC72bd36380533aaE0f419b14", value: Int(truncating: value as NSNumber))
                    } label: {
                        HStack {
                            Spacer()
                            Text("Send tx")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .padding(.vertical, 15)
                        .background(Color.blue)
                        .cornerRadius(32)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
                }
                
                Button {
                    viewModel.disconnect()
                } label: {
                    HStack {
                        Spacer()
                        Text("Disconnect")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding(.vertical, 15)
                    .background(Color.red)
                    .cornerRadius(32)
                }
                .padding(.horizontal, 30)
                .padding(.top, 60)
            }
        }
    }
}

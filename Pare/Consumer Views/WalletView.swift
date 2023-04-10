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

        NavigationView {

            VStack {


                if viewModel.session == nil {



                    VStack {
                        VStack(spacing: 10){

                            HStack{
                                Text("Connect your wallet to get started.")
                                    .font(.title3)
                                    .padding()
                                Spacer()
                            }


                            Button {
                                viewModel.connect(wallet: Wallets.TrustWallet)
                            } label: {
                                HStack {
                                    Spacer()
                                    Text(Wallets.TrustWallet.name)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.accentColor)
                                    Spacer()
                                }
                                .frame(width: 350, height: 50)
                                .overlay(

                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .stroke(Color.accentColor, lineWidth: 1)
                                )

                            } //: BUTTON


                        }//: VSTACK

                        VStack{

                            HStack{
                                Text("What is a wallet?")
                                    .font(.title3)
                                    .padding()
                                Spacer()
                            }

                            Video(videoID: "SQyg9pyJ1Ac")
                                .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                                .cornerRadius(12)
                                .padding(.horizontal, 24)


                        } //: VSTACK
                        .padding(.vertical) 



                        Spacer()

                    } //: VSTACK

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

                    Spacer() 

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

            } //: VSTACK
            .navigationTitle("Wallet")
            .navigationBarTitleDisplayMode(.large)

        } //: NAV VIEW
    }
}

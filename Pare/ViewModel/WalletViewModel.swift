//
//  WalletViewModel.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/30/23.
//

import Foundation
import Firebase
import MagicSDK
import MagicSDK_Web3
import PromiseKit
import Web3PromiseKit
import Web3ContractABI
import BigInt

class WalletViewModel: ObservableObject{

    // MARK: - PROPERTIES
    @Published var userTokenBalance: BigUInt = 0
    
    
    // Get balance
    func getBalance(magic: Magic, userPublicAddress: String, completion: @escaping (BigUInt?) -> Void){

        // 2nd instance of web3 (1st instance in getAccount() - AuthViewModel)
        var web3 = Web3(provider: magic.rpcProvider)

        do {

            // Create USDC contract instance
            let contractAddress = try EthereumAddress(hex: "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174", eip55: false)
            let USDCcontract = web3.eth.Contract(type: GenericERC20Contract.self, address: contractAddress)

            let userAddress = try EthereumAddress(hex: "0x3FF4e98BE04Ba8c0d96a4b5eE6BD8D7eE834CbeC", eip55: false)
            // Create user public ethereum address
//            let userAddress = try EthereumAddress(ethereumValue: userPublicAddress)

            // Get balance of some address
            firstly {
                try USDCcontract.balanceOf(address: EthereumAddress(hex: userPublicAddress, eip55: false)).call()
            }.done { outputs in
                print("NEW")
                let balanceInWei = outputs["_balance"] as? BigUInt

                print(balanceInWei!)

                let conversionFactor = BigUInt(10).power(18)


               // Divide the balance by the conversion factor to get the balance in ETH
                let balanceInEth = balanceInWei! / conversionFactor

                print(balanceInEth)

               self.userTokenBalance = balanceInEth


               completion(balanceInEth)

            }.catch { error in
                print(error)
            }


        } catch {

            print("Error: \(error) - getBalance, WalletViewModel")
            completion(nil)

        } //: CATCH


    } //: FUNC GET BALANCE

    // Send transaction (ERC-20 token)
    func sendTransaction(magic: Magic, userPublicAddress: String, amount: Double){

        do{

            // 3nd instance of web3
            var web3 = Web3(provider: magic.rpcProvider)

            // Create a dummy erc-20 contract

//            let contractAddress = try EthereumAddress(hex: "0xBC301D905Ccee51Dd9e7b60Bb807aCC69bD00913", eip55: false)

            let contractAddress = try EthereumAddress(hex: "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174", eip55: false)

            let contract = web3.eth.Contract(type: GenericERC20Contract.self, address: contractAddress)
            let sendAmount = amount * 1e18

            // Send some tokens to another address (signing will be done by the node)
            let myAddress = try EthereumAddress(hex: userPublicAddress, eip55: false)
            firstly {
                web3.eth.getTransactionCount(address: myAddress, block: .latest)
            }.then { nonce in

                // Note: Need to change address to Yuan Ho
                // Should we decrease gasPrice that we're willing to pay?
                try contract.transfer(to: EthereumAddress(hex: "0x551Fa22d9722286dceA636516683B8B3b8a6aF0D", eip55: false), value: BigUInt(sendAmount)).send(
                    nonce: nonce,
                    from: EthereumAddress(hex: userPublicAddress, eip55: false),
                    value: 0,
                    gas: 150000,
                    gasPrice: EthereumQuantity(quantity: 21.gwei)
                )
            }.done { txHash in

                // Success

            }.catch { error in
                print("sendTransaction, WalletViewModel")
                print(error)
            }


        } catch {
            print("sendTransaction, WalletViewModel")
            print(error)
        }

    } //: SEND TRANSACTION


}

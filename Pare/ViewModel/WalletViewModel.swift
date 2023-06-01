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

class WalletViewModel: ObservableObject{

    // MARK: - PROPERTIES
    @Published var userTokenBalance: BigUInt = 0
    
    
    // Get balance
    func getBalance(magic: Magic, userPublicAddress: String, completion: @escaping (BigUInt?) -> Void){

        // 2nd instance of web3 (1st instance in getAccount() - AuthViewModel)
        var web3 = Web3(provider: magic.rpcProvider)

        do {

            // Create a dummy erc-20 contract instance
            let contractAddress = try EthereumAddress(hex: "0xfe4F5145f6e09952a5ba9e956ED0C25e3Fa4c7F1", eip55: false)

            let USDCcontract = web3.eth.Contract(type: GenericERC20Contract.self, address: contractAddress)

            // Create user public ethereum address
            let userAddress = try EthereumAddress(ethereumValue: userPublicAddress)

            // Find user's balance of ERC-20 token
            let balance = USDCcontract.balanceOf(address: userAddress)

            // Balance is a SolidityReadInvocation type, we can apply call function on it
            balance.call{ result, error in
                if let error = error{
                    print("Error (getBalance, WalletViewModel):", error)
                    return
                }

                if let result = result{

                    // Wei-to-ether conversion factor (1 ether = 10^18 wei)
                    let conversionFactor = BigUInt(10).power(18)

                    // Perform the conversion
                    if let balanceInWei = result["_balance"] as? BigUInt {
                        // Divide the balance by the conversion factor to get the balance in ETH
                        let balanceInEth = balanceInWei / conversionFactor

                        self.userTokenBalance = balanceInEth

                        completion(balanceInEth)

                    } else {
                        print("Invalid balance value or conversion failed - getBalance, WalletViewModel")
                        completion(nil)
                    }


                } //: RESULT

            } //: BALANCE

        } catch {

            print("Error creating EthereumAddress: \(error) - getBalance, WalletViewModel")
            completion(nil)

        } //: CATCH


    } //: FUNC GET BALANCE

    // Send transaction (ERC-20 token)
    func sendTransaction(magic: Magic, userPublicAddress: String){

        do{

            // 3nd instance of web3
            var web3 = Web3(provider: magic.rpcProvider)

            // Create a dummy erc-20 contract
            let contractAddress = try EthereumAddress(hex: "0xfe4F5145f6e09952a5ba9e956ED0C25e3Fa4c7F1", eip55: false)
            let contract = web3.eth.Contract(type: GenericERC20Contract.self, address: contractAddress)

            // Send some tokens to another address (signing will be done by the node)
            let myAddress = try EthereumAddress(hex: userPublicAddress, eip55: false)
            firstly {
                web3.eth.getTransactionCount(address: myAddress, block: .latest)
            }.then { nonce in

                // Note: Need to change address to Yuan Ho
                // Should we decrease gasPrice that we're willing to pay?
                try contract.transfer(to: EthereumAddress(hex: "0x551Fa22d9722286dceA636516683B8B3b8a6aF0D", eip55: false), value: 400000).send(
                    nonce: nonce,
                    from: EthereumAddress(hex: "0x3ff4e98be04ba8c0d96a4b5ee6bd8d7ee834cbec", eip55: false),
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

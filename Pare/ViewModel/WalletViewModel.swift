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
    @Published var userTokenBalance: NSDecimalNumber = 0.0
    private static let backendURL = URL(string: "http://127.0.0.1:4242")!
    
    
    // Get balance
    func getBalance(magic: Magic, userPublicAddress: String, completion: @escaping (NSDecimalNumber?) -> Void){

        // 2nd instance of web3 (1st instance in getAccount() - AuthViewModel)
        var web3 = Web3(provider: magic.rpcProvider)

        do {

            // Create USDC contract instance
            let contractAddress = try EthereumAddress(hex: "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174", eip55: false)
            let USDCcontract = web3.eth.Contract(type: GenericERC20Contract.self, address: contractAddress)

            // User public address
            let userAddress = try EthereumAddress(hex: "0x3FF4e98BE04Ba8c0d96a4b5eE6BD8D7eE834CbeC", eip55: false)
            // Create user public ethereum address

            // Get balance of some address
            firstly {
                try USDCcontract.balanceOf(address: EthereumAddress(hex: userPublicAddress, eip55: false)).call()
            }.done { outputs in

                let balanceInWei = outputs["_balance"] as? BigUInt
//                print("Balance in Wei: \(balanceInWei!)")

                let conversionFactor = NSDecimalNumber(decimal: pow(10, 6))
//                print("Conversion Factor: \(conversionFactor)")

                // Convert the balance to Decimal
                let balanceInDecimal = NSDecimalNumber(string: balanceInWei?.description) ?? 0

                // Divide the balance by the conversion factor to get the balance in ETH
                let balanceInEth = balanceInDecimal.dividing(by: conversionFactor)
//                print("Balance in ETH: \(balanceInEth)")

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
    func sendTransaction(magic: Magic, userPublicAddress: String, amount: BigUInt){

        do{

            // 3nd instance of web3
            let web3 = Web3(provider: magic.rpcProvider)

            // Create usdc contract instance
            let contractAddress = try EthereumAddress(hex: "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174", eip55: false)
            let USDCContract = web3.eth.Contract(type: GenericERC20Contract.self, address: contractAddress)

            // Send some tokens to another address (signing will be done by the node)
            let myAddress = try EthereumAddress(hex: userPublicAddress, eip55: false)
            let shopAddress = try EthereumAddress(hex: "0xA741b63997bbF5AaC72bd36380533aaE0f419b14", eip55: false)

            firstly {
                web3.eth.getTransactionCount(address: myAddress, block: .latest)
            }.then { nonce in

                // Note: 8000000 = 8 ETH since ERC-20 tokens round to 6 decimal places
                try USDCContract.transfer(to: shopAddress, value: amount).send(
                    nonce: nonce,
                    from: EthereumAddress(hex: userPublicAddress, eip55: false),
                    value: 0,
                    gas: 150000,
                    gasPrice: EthereumQuantity(quantity: 200.gwei)
                )
            }.done { txHash in
                // Success
                print("Tnx Hash (WalletViewModel): \(txHash)")

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

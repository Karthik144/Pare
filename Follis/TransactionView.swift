//
//  TransactionView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/16/23.
//

import SwiftUI

struct TransactionView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var router: Router
    @State private var showPopup = false
    @State private var itemName = ""
    @State private var numberOfItems: Int?
    @State private var itemPrice: Double?
    @State private var transactions = [Order]()
    @State private var seen: [Bool] = []
    @State private var subTotal = 0.00
    @State private var total = 0.00


    init(){
        UITableView.appearance().backgroundColor = .white
    }

    // MARK: - BODY
    var body: some View {

        NavigationView{

            VStack(spacing: 0){

                HStack{
                    Button("Add"){
                        withAnimation{
                            showPopup.toggle()
                        }
                    }
                    .frame(width: 80, height: 45)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color(red: 0.167, green: 0.29, blue: 0.933))
                            .frame(width:80, height: 45)
                    )
                    .navigationTitle("New Order")

                    Spacer()
                } //: HSTACK




                Spacer()

                List{

                    ForEach(transactions) { transaction in
                        OrderItemView(itemName: transaction.itemName, itemPrice: String(transaction.itemPrice), itemQuantity: String(transaction.itemQuantity))
                    }

                }

                Spacer()


                if transactions.count >= 1 {

                    VStack(spacing: 10){
                        HStack{

                            Text("Subtotal")
                                .padding(.leading, 20)
                                .foregroundColor(Color.gray)


                            Spacer()

                            Text(String(subTotal))
                                    .foregroundColor(Color.gray)
                                    .padding(.trailing, 20)
                        }

                        HStack{

                            Text("Network Discount")
                                .foregroundColor(Color.gray)
                                .padding(.leading, 20)

                            Spacer()

                            Text("0.25%")
                                .foregroundColor(Color.gray)
                                .padding(.trailing, 20)
                        }

                        HStack{

                            Text("Total")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0.167, green: 0.29, blue: 0.933))
                                .padding(.leading, 20)

                            Spacer()

                            Text(String(round(total * 100)/100.0) + " " + "USDC")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0.167, green: 0.29, blue: 0.933))
                                .padding(.trailing, 20)

                        }

                        Button {
                            Router.shared.selectedTab = 3
                        } label: {
                            Text("Done")
                        }
                        .frame(width: 210, height: 50)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 0.167, green: 0.29, blue: 0.933))
                                .frame(width:210, height: 50)
                        )

                    } //: VSTACK
                    .padding(.bottom, 25)

                    Spacer()

                }


            } //: VSTACK




        }
        .popupNavigationView(horizontalPadding: 30, show: $showPopup) {

            // Popup content
            VStack(spacing: 0){

                Form {
                    Section(){
                        TextField("Item name", text: $itemName)
                            .textFieldStyle(.roundedBorder)
                            .listRowSeparator(.hidden)


                        TextField("Number of items", value: $numberOfItems, format: .number)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .listRowSeparator(.hidden)



                        TextField("Item price", value: $itemPrice, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                            .listRowSeparator(.hidden)


                    } //: SECTION
                    .padding([.top], -15)
                    .listRowSeparator(.hidden)


                } //: FORM
                .padding([.top], -15)
                .listRowSeparator(.hidden)



                Button(action: {

                    addOrder(name: itemName, quantity: numberOfItems ?? 0, price: itemPrice ?? 0)
                    showPopup.toggle()
                }, label: {
                    Text("Done")
                })
                .frame(width: 90, height: 35)
                .padding()
                .foregroundColor(Color.white)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color(red: 0.167, green: 0.29, blue: 0.933))
                        .frame(width:90, height: 35)
                )
            } //: VSTACK
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close"){
                        withAnimation{showPopup.toggle()}
                    }
                    .padding()
//                    .frame(width: 75, height: 30)
//                    .foregroundColor(Color.white)
//                    .background(
//                        RoundedRectangle(cornerRadius: 50)
//                            .fill(Color.red)
//                            .frame(width:70, height: 30)
//                    )
                }
            }
        } // POP UP NAV VIEW





    }

    func addOrder(name: String, quantity: Int, price: Double){

        let newOrder = Order(itemName: name, itemQuantity: quantity, itemPrice: price)
        transactions.append(newOrder)
        seen.append(false)
        createSummary()

        print(transactions.count)
    }

    func createSummary(){

        for i in transactions.indices {

            if (seen[i] != true){
                subTotal += (transactions[i].itemPrice * Double(transactions[i].itemQuantity))
                print("SUBTOTAL")
                print(subTotal)
                seen[i] = true
            } else {
                continue
            }

        }

        total = (subTotal * 0.9975)

    }


}






// MARK: - PREVIEW
//struct TransactionView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionView()
//    }
//}

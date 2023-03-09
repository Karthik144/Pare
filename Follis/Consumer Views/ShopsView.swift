//
//  ShopsView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct ShopsView: View {

    // MARK: - PROPERTIES
    @ObservedObject private var viewModel = ShopViewModel()
    @State private var orderScheduled = true
    @State private var showModal = false
    @State private var totalShops = [Shop]()

    // MARK: - BODY
    var body: some View {

        NavigationView {
            VStack{

                SearchBar()
                    .padding(.top, 10)

                ZStack{

                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .fill(Color.accentColor)
                        .frame(width: 340, height: 75)

                    HStack{

                        Spacer()

                        VStack(alignment: .leading, spacing: 0){

                            Text("Ordered Scheduled")
                                .foregroundColor(Color.white)
                                .font(.title2)
                                .fontWeight(.bold)

                            HStack{

                                Text("In Progress")
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.light)

                                Circle()
                                    .frame(width: 2, height: 2)
                                    .foregroundColor(Color.white)

                                Text("Scheduled for 3pm")
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.light)
                            }
                        }

                        Spacer()


                        Image(systemName: "clock.badge.checkmark")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .frame(width: 30, height: 30)


                        Spacer()

                    } //: HSTACK

                } //: ZSTACK
                .onTapGesture {
                    showModal.toggle()
                }.sheet(isPresented: $showModal) {
                    OrderStatusModalView(shop: "Otto Turkish Street Food", address: "111 W Water St, Charlottesville, VA 22902", orderNumber: "#325", orderStatus: "In Progress")
                }

                HStack{
                    Text("Near You")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .padding(.leading, 10)

                    Spacer()
                }

                ScrollView {


                    LazyVStack{

                        ForEach(totalShops) { shop in

                            NavigationLink {
                                ShopItemView(shop: shop,rootIsActive: $isActive)
                            } label: {
                                ShopCell(shop: shop)
                                    .padding(.leading, 0)
                                    .padding()
                            }

                        } //: FOR EACH

                    } //: LAZYVSTACK

                } //: SCROLL VIEW


            } //: VSTACK
            .onAppear(){
                viewModel.fetchShops { shops in
                    self.totalShops = shops
                }
            }


        } //: NAV VIEW
//        .navigationViewStyle(StackNavigationViewStyle())
    } //: VIEW 
}


// MARK: - PREVIEW
//struct ShopsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopsView()
//    }
//}

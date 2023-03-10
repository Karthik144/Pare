//
//  AddItemView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct AddItemView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: ShopViewModel
    @State private var didTap = false
    @State private var goesToDetail = false
    @State private var goesToShopItemView = false
    @State private var addOptions = [Add]()
    @State private var requiredOptions = [Required]()
    @State private var modificationOptions = [Modification]()
    let item: MenuItem
    let shop: Shop

    

    // MARK: - BODY
    var body: some View {

        VStack(alignment: .leading){

            HStack{

                Image("OttoBowl")
                    .resizable()
                    .frame(width: 115, height: 115)
                    .scaledToFit()
                    .cornerRadius(7)

                VStack(alignment: .leading){



                    Text(item.name)
                        .font(.title3)
                        .fontWeight(.bold)

                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .lineLimit(2)


                    HStack{
                        Image("Rocket")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .scaledToFit()

                        Text("Popular")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.orange)
                    } //: HSTACK


                } //: VSTACK
                .padding(.leading, 5)


            } //: HSTACK
            .padding()

            ScrollView{

                LazyVStack(alignment: .leading){

                    Text("Required")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                    Text("Choose 1")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .padding(.leading, 20)

                    VStack{

                        ForEach(requiredOptions) { option in

                            Button {
                                didTap.toggle()
                            } label: {

                                RequiredItemCell(requiredItem: option, item: item)
                            }
                            .padding(.leading, 20)
                            .padding(5)

                        } //: FOR EACH

                    } //: VSTACK


                    Text("Modifications")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading, 20)

                    VStack(alignment: .leading){

                        ForEach(modificationOptions) { option in

                            Button {
                                didTap.toggle()
                            } label: {
                                ModificationItemCell(modificationItem: option, item: item)
                            }
                            .padding(.leading, 20)
                            .padding(5)

                        } //: FOR EACH

                    } //: VSTACK

                    Text("Add More")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading, 20)

                    VStack(alignment: .leading){

                        ForEach(addOptions) { option in

                            Button {
                                didTap.toggle()
                            } label: {
                                AddItemCell(item: item, addItem: option)
                            }
                            .padding(.leading, 20)
                            .padding(5)

                        } //: FOR EACH

                    } //: VSTACK

                } //: LAZYVSTACK


            } //: SCROLL VIEW


            HStack{

                Spacer()

//                Button {
//                    // Add action
//                    viewModel.cartItems.append(item)
//
//                } label: {
//                    Text("Add to Cart")
//                        .frame(width: 110, height: 40)
//                        .overlay(
//
//                            RoundedRectangle(cornerRadius: 8, style: .continuous)
//                                .stroke(Color.accentColor, lineWidth: 1)
//                        )
//                }

                NavigationLink(
                    destination: ShopItemView(shop: shop),
                    isActive: $goesToShopItemView) {
                    Button(action: {

                        viewModel.cartItems.append(item)
                        viewModel.updateCartActiveStatus(cartActive: true)
                        goesToShopItemView = true

                    }) {
                        Text("Add to Cart")
                            .frame(width: 110, height: 40)
                            .overlay(

                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )
                    }
                }

                Spacer()


//                NavigationLink {
//                    CheckoutView(item: item, shop: shop)
//
//                } label: {
//                    Text("Order")
//                        .foregroundColor(Color.white)
//                        .background(
//
//                            RoundedRectangle(cornerRadius: 8, style: .continuous)
//                                .fill(Color.accentColor)
//                                .frame(width: 110, height: 40)
//
//                        )
//                }

                NavigationLink(
                    destination: CheckoutView(shop: shop),
                    isActive: $goesToDetail) {
                    Button(action: {

                        viewModel.cartItems.append(item)
                        goesToDetail = true

                    }) {
                        Text("Order")
                            .foregroundColor(Color.white)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color.accentColor)
                                    .frame(width: 110, height: 40)
                            )
                    }
                }


                Spacer()


            } //: HSTACK
            .padding()




        } //: VSTACK
        .onAppear(){

            viewModel.fetchItemAddOptions(withUID: shop.id ?? "", itemUID: item.id ?? "") { addOptions in
                self.addOptions = addOptions
            }

            viewModel.fetchItemRequiredOptions(withUID: shop.id ?? "", itemUID: item.id ?? "") { requiredOptions in
                self.requiredOptions = requiredOptions
            }

            viewModel.fetchItemModificationOptions(withUID: shop.id ?? "", itemUID: item.id ?? "") { modificationOptions in
                self.modificationOptions = modificationOptions
            }

        }



    }
}


// MARK: - PREVIEW
//struct AddItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemView()
//    }
//}
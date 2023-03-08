//
//  AddItemView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct AddItemView: View {

    // MARK: - PROPERTIES
    @State private var didTap = false

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



                    Text("Istanbowl")
                        .font(.title3)
                        .fontWeight(.bold)

                    Text("Try our delicious bowl with white rice, mixed greens, beet salad, red cabbage salad, pickles, and Tzatzki")
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

                    Text("Meat")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                    Text("Choose 1")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .padding(.leading, 20)

                    VStack{

                        ForEach((0...1), id: \.self) {_ in

                            Button {
                                didTap.toggle()
                            } label: {
                                AddItemCell(addMoreType: false, price: "")
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

                        ForEach((0...4), id: \.self) {_ in

                            Button {
                                didTap.toggle()
                            } label: {
                                AddItemCell(addMoreType: false, price: "")
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

                        ForEach((0...3), id: \.self) {_ in

                            Button {
                                didTap.toggle()
                            } label: {
                                AddItemCell(addMoreType: true, price: "0.50")
                            }
                            .padding(.leading, 20)
                            .padding(5)

                        } //: FOR EACH

                    } //: VSTACK

                } //: LAZYVSTACK


            } //: SCROLL VIEW


            HStack{

                Spacer()

                Button {
                    // Add action
                } label: {
                    Text("Add to Cart")
                        .frame(width: 110, height: 40)
                        .overlay(

                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(Color.accentColor, lineWidth: 1)
                        )
                }

                Spacer()


                NavigationLink {
                    CheckoutView()
                    
                } label: {
                    Text("Order")
                        .foregroundColor(Color.white)
                        .background(

                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: 110, height: 40)

                        )
                }


                Spacer()


            } //: HSTACK
            .padding()




        } //: VSTACK



    }
}


// MARK: - PREVIEW
struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}

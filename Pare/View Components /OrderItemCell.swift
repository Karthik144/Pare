//
//  OrderItem.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct OrderItemCell: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: ShopViewModel
    @State var itemQuantity: Int
    let itemName: String
    let itemPrice: String
    let rewardPoints: String
    let index: Int
    
    let popup: Bool
    
    @State var finalTotal:Double
    
    
    // MARK: - BODY
    var body: some View {
        HStack{
            
            if popup == true {
                
                
                Text("\(itemQuantity)")
                    .overlay(
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            .stroke(Color(red: 0.167, green: 0.29, blue: 0.933), lineWidth: 0.5)
                            .frame(width: 20, height: 20)
                        
                    )
                    .padding(.trailing, 8)
                
                
            } else {
                
                Menu{
                    
                    Button(action: {
                        viewModel.updateQuantity(index: index, newQuantity: 1)
                        itemQuantity = 1
                        
                        finalTotal = viewModel.calcTotal()
                    }, label: {
                        Text("+1")
                    })
                    
                    Button(action: {
                        viewModel.updateQuantity(index: index, newQuantity: 2)
                        itemQuantity = 2
                        
                        finalTotal = viewModel.calcTotal()
                        
                    }, label: {
                        Text("+2")
                    })
                    
                    Button(action: {
                        viewModel.updateQuantity(index: index, newQuantity: 3)
                        itemQuantity = 3
                        
                        finalTotal = viewModel.calcTotal()
                        
                    }, label: {
                        Text("+3")
                    })
                    
                    Button(action: {
                        viewModel.cartItems.remove(at: index)
                        itemQuantity = 0
                        
                        finalTotal = viewModel.calcTotal()
                    }, label: {
                        Text("Delete")
                            .foregroundColor(Color.red)
                    })
                    
                } label: {
                    Label(
                        title: {Text("\(itemQuantity)")
                                .overlay(
                                    RoundedRectangle(cornerRadius: 2, style: .circular)
                                        .stroke(Color(red: 0.167, green: 0.29, blue: 0.933), lineWidth: 0.5)
                                        .frame(width: 20, height: 20)
                                    
                                )}, icon: {Image(systemName: "pencil.circle.fill").padding(.trailing, 5)}
                    )
                }
                .padding(.trailing, 10)
                
                
            }
            
            
            
            Text(itemName)
                .foregroundColor(.black)
                .lineLimit(1)
            
            Spacer()
            
            Text("\(String(itemPrice)) USDC")
                .padding()
                .lineLimit(1)
            
            HStack{
                Image("GlowingStar")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .scaledToFit()
                
                Text("+\(rewardPoints)")
                
            } //: HSTACK
            
            
        } //: HSTACK
        .onAppear{
            
        }
    }
}

//struct OrderItem_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderItemCell()
//    }
//}

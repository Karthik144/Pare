//
//  ShopItemView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct ShopItemView: View {
    var body: some View {
        
        VStack{
            
            HStack{
                
                Image("OttoStore")
                    .resizable()
                    .frame(width: 115, height: 115)
                    .scaledToFit()
                    .cornerRadius(7)
                
                VStack(alignment: .leading){
                    
                    
                    
                    Text("Otto Turkish Street Food")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack{
                        
                        Text("Food")
                            .foregroundColor(Color.gray)
                        
                        Circle()
                            .foregroundColor(Color.gray)
                            .frame(width: 2, height: 2)
                        
                        Text("Turkish")
                            .foregroundColor(Color.gray)
                        
                        Circle()
                            .foregroundColor(Color.gray)
                            .frame(width: 2, height: 2)
                        
                        HStack{
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.black)
                            Text("4.86")
                                .foregroundColor(Color.black)
                        } //: HStack
                        
                        
                        
                    }//: HStack
                    
                    Text("Open Now")
                        .foregroundColor(Color.green)
                    
                    
                } //: VSTACK
                .padding(.leading, 5)
                
                
            } //: HSTACK
            .padding()
            
            HStack{
                Text("Bowls")
                    .fontWeight(.bold)
                    .font(.title3)
                Spacer()
            } //: HSTACK
            .padding(.leading, 20)
            .padding(.bottom, 0)
            
            
            ScrollView{
                
                LazyVStack{
                    
                    ForEach((0...1), id: \.self) {_ in
                        
                        NavigationLink(destination: AddItemView()) {
                            ItemCell()
                                .padding(.leading, 0)
                                .padding()
                        }
                        
                        
                    } //: FOR EACH
                    
                } //: LazyVStack
                
                
            }//: SCROLL VIEW
            
            
            HStack{
                Text("Wraps")
                    .fontWeight(.bold)
                    .font(.title3)
                Spacer()
            } //: HSTACK
            .padding(.leading, 20)
            .padding(.bottom, 0)
            
            
            ScrollView{
                
                LazyVStack{
                    
                    ForEach((0...1), id: \.self) {_ in
                        
                        NavigationLink(destination: ShopItemView()) {
                            ItemCell()
                                .padding(.leading, 0)
                                .padding()
                        }
                        
                        
                    } //: FOR EACH
                    
                } //: LazyVStack
                
                
            }//: SCROLL VIEW
            
            
            
        }
    }//: VSTACK
    
}

struct ShopItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShopItemView()
    }
}

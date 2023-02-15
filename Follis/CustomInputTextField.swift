//
//  CustomInputTextField.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import SwiftUI

struct CustomInputTextField: View {
    
    
    // MARK: - PROPERTIES
    let isSecureField: Bool?
    let placeholderText: String
    @Binding var text: String
    
    // MARK: - BODY
    var body: some View {
        
        VStack(alignment: .leading){
            
            if isSecureField ?? false {
                SecureField(placeholderText, text: $text)
                    .background(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .stroke(Color.white, lineWidth: 1.5)
                            .frame(width: 310, height: 65)
                    )
                    .frame(width: 310, height: 65, alignment: .center)
                    .foregroundColor(Color.white)

            } else {
                TextField(placeholderText, text: $text)
                    .background(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .stroke(Color.white, lineWidth: 1.5)
                            .frame(width: 310, height: 65)
                    )
                    .frame(width: 310, height: 65, alignment: .center)
                    .foregroundColor(Color.white)
                
            }
            
        }//: VSTACK
        .padding()
    }
    
}

struct CustomInputTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputTextField(isSecureField: false, placeholderText: "Testing this...", text: .constant(""))
    }
}

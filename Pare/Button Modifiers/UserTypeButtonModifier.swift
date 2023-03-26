//
//  UserTypeButtonModifier.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/14/23.
//

import SwiftUI

struct UserTypeButtonModifier: ViewModifier {

    func body(content: Content) -> some View {

        content
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 1.5)
                    .frame(width:295, height: 50)
            )
            .frame(width: 295, height: 50, alignment: .center)
    } // FUNC BODY
}

//
//  NextButtonModifier.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/14/23.
//

import SwiftUI

struct NextButtonModifier: ViewModifier {

    func body(content: Content) -> some View {

        content
            .foregroundColor(Color.black)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.white)
                    .frame(width:230, height: 75)
            )
    } // FUNC BODY
}

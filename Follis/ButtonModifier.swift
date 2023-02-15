//
//  ButtonModifier.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import SwiftUI

struct ButtonModifier: ViewModifier {

    func body(content: Content) -> some View {

        content
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blue)
                    .frame(width:300, height: 50)
            )
    } // FUNC BODY
}

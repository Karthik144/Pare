//
//  StartButtonModifier.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/18/23.
//

import SwiftUI

struct StartButtonModifier: ViewModifier {

    func body(content: Content) -> some View {

        content
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color(red: 0.167, green: 0.29, blue: 0.933))
                    .frame(width:140, height: 55)
            )
    } // FUNC BODY
}

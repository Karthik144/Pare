//
//  NextButtonModifier.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/14/23.
//

import SwiftUI

struct NextButtonModifier: ViewModifier {

    let customColor = Color(
        red: Double(0x2B) / 255,
        green: Double(0x4A) / 255,
        blue: Double(0xEE) / 255,
        opacity: 1.0
    )

    func body(content: Content) -> some View {

        content
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(customColor)
                    .frame(width:230, height: 75)
            )
    } // FUNC BODY
}

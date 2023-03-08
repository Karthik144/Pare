//
//  GetStartedButtonModifier.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/14/23.
//

import SwiftUI

struct GetStartedButtonModifier: ViewModifier {

    func body(content: Content) -> some View {

        content
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color(red: 0.167, green: 0.29, blue: 0.933))
                    .frame(width:230, height: 75)
            )
    } // FUNC BODY
}

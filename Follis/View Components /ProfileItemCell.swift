//
//  ProfileItemCell.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/8/23.
//

import SwiftUI

struct ProfileItemCell: View {

    // MARK: - PROPERTIES
    let imageName: String
    let cellText: String 

    // MARK: - BODY
    var body: some View {
        HStack{

            HStack {
                Image(systemName: imageName)
                    .foregroundColor(Color.black)
                Text(cellText)
                    .foregroundColor(Color.black)
                
            } //: HSTACK
            .padding()


            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(Color.black)
            .padding()

        } //: HSTACK
    }
}


// MARK: - PREVIEW
struct ProfileItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ProfileItemCell(imageName: "person", cellText: "Personal")
    }
}

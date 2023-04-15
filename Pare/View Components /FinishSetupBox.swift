//
//  FinishSetupBox.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/14/23.
//

import SwiftUI

struct FinishSetupBox: View {

    var body: some View {
        ZStack{

            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .fill(Color.accentColor)
                .frame(width: UIScreen.main.bounds.width - 50, height: 90)

            VStack {

                // Header
                HStack{

                    Text("Finish setting up your account")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.top)
//                                .padding()

                    Spacer()

                } //: HSTACK

                // Details
                HStack {
                    HStack{

                        Text("2 Steps")
                            .foregroundColor(Color.white)
                            .font(.subheadline)

                        Circle()
                            .frame(width: 2, height: 2)
                            .foregroundColor(Color.white)

                        Text("7 mins")
                            .foregroundColor(Color.white)
                            .font(.subheadline)

                    } //: HSTACK
//                            .padding()

                    Spacer()
                } //: HSTACK



            } //: VSTACK
            .padding(.leading)
            .padding(.bottom)



        } //: ZSTACK
        .frame(width: UIScreen.main.bounds.width - 50, height: 90)
        .padding()
    }
}

struct FinishSetupBox_Previews: PreviewProvider {
    static var previews: some View {
        FinishSetupBox()
    }
}

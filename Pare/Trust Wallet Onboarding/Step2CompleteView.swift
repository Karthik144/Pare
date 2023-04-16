//
//  Step2CompleteView.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/15/23.
//

import SwiftUI

struct Step2CompleteView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var isActive: Bool
//    @Environment(\.dismiss) private var dismiss

    // MARK: - BODY
    var body: some View {

        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()

            VStack{

                Spacer()

                Image(systemName: "party.popper.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 85, height: 85)
                    .foregroundColor(Color.white)
                    .padding()

                Text("You're done with Step 2!")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)

                Button {
                    viewModel.updateUserWalletSetupStatus()
                    isActive = false 
                } label: {
                    Text("Done")
                        .foregroundColor(Color.accentColor)
                        .fontWeight(.semibold)
                        .frame(width: 300, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.white)
                                .frame(width: 300, height: 50)
                        )
                }

                Spacer()


            } //: VSTACK

        } //: ZSTACK
    }
}


// MARK: - PREVIEW
//struct Step2CompleteView_Previews: PreviewProvider {
//    static var previews: some View {
//        Step2CompleteView()
//    }
//}

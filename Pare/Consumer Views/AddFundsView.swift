//
//  AddFundsView.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/28/23.
//

import SwiftUI

struct AddFundsView: View {

    // MARK: - PROPERTIES

    // MARK: - BODY
    var body: some View {

        VStack(){

            // Title
            HStack{

                Text("Add funds to your wallet")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                Spacer()

            } //: HSTACK


            // Preface
            VStack(alignment: .leading, spacing: 30){

                Text("Think of your wallet like Venmo.")

                Text("When you add money, you’re purchasing tokens that you can spend at any shop on Pare. ")

                Text("These tokens let you earn the **highest rewards** and the **lowest meal prices**.")

                Text("To ensure security, we use a third-party to verify your identity. So please have your SSN and ID ready.")

                Text("This data is not stored by us or the third-party. **It is solely for verification to prevent fraudulent purchases.** ")


            } //: VSTACK
            .padding()


            Spacer()

            // Button
            Button {

            } label: {

                Text("Add Funds")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 8,  style: .continuous)
                            .fill(Color.accentColor)
                            .frame(width: 300, height: 50)
                    )

            } //: BUTTON
            .padding(.bottom, 35)

        } //: VSTACK
        .navigationBarTitle("")
    }
}


// MARK: - PREVIEW
struct AddFundsView_Previews: PreviewProvider {
    static var previews: some View {
        AddFundsView()
    }
}

//
//  WalletInfoView.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/28/23.
//

import SwiftUI

struct WalletInfoView: View {

    // MARK: - PROPERTIES

    // MARK: - BODY
    var body: some View {

        if #available(iOS 16.0, *){

            VStack{

                // Public Key
                HStack{

                    VStack(alignment: .leading){

                        Text("Public Key")
                            .fontWeight(.bold)
                            .font(.headline)

                        Text("0x3ff4e98be04ba8c0d96a4b5e....")
                            .lineLimit(1)
                            .padding(.trailing)
                            .fontWeight(.light)

                    } //: VSTACK

                    Spacer()

                    Button(action: {
                        copyToClipboard(text: "textToCopy")
                    }) {

                        Image(systemName: "doc.on.doc")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                            .foregroundColor(Color.white)
                            .background(
                                RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                    .fill(Color.accentColor)
                                    .frame(width: 50, height: 40)
                            )
                    }

                    Spacer()

                } //: HSTACK
                .padding()

                // What is a public key?
                VStack(alignment: .leading){

                    Text("What is a public key?")
                        .fontWeight(.bold)
                        .font(.headline)

                    Text("Think of it as a username. Anyone can send you money if they have this.")
                        .fontWeight(.light)


                } //: VSTACK
                .padding()

                Spacer()

            } //: VSTACK
            .navigationTitle("Wallet Info")
            .navigationBarTitleDisplayMode(.inline)


        } else {

            VStack{

                // Public Key
                HStack{

                    VStack(alignment: .leading){

                        Text("Public Key")
                            .fontWeight(.bold)
                            .font(.headline)

                        Text("0x3ff4e98be04ba8c0d96a4b5e....")
                            .lineLimit(1)
                            .padding(.trailing)

                    } //: VSTACK

                    Spacer()

                    Button(action: {
                        copyToClipboard(text: "textToCopy")
                    }) {

                        Image(systemName: "doc.on.doc")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                            .foregroundColor(Color.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10,  style: .continuous)
                                    .fill(Color.accentColor)
                                    .frame(width: 50, height: 40)
                            )
                    } //: BUTTON

                    Spacer()

                } //: HSTACK
                .padding()

                // What is a public key?
                VStack(alignment: .leading){

                    Text("What is a public key?")
                        .fontWeight(.bold)
                        .font(.headline)

                    Text("Think of it as a username. Anyone can send you money if they have this.")


                } //: VSTACK

                Spacer() 

            } //: VSTACK
            .navigationTitle("Wallet Info")
            .navigationBarTitleDisplayMode(.inline)

        } //: ELSE


    } //: BODY

    private func copyToClipboard(text: String) {
        UIPasteboard.general.string = text
    }

}


// MARK: - PREVIEW
struct WalletInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WalletInfoView()
    }
}

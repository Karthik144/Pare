//
//  Benefit1View.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/27/23.
//

import SwiftUI

struct BenefitView: View {

    // MARK: - PROPERTIES
    let benefitNumber: String
    let benefit: String
    let subBenefit: String 
    let image: String

    let customColor = Color(red: 43/255, green: 74/255, blue: 238/255)


    // MARK: - BODY
    var body: some View {

        VStack(alignment: .leading, spacing: 5){

            // Header
            Text("Welcome to Pare")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
                .padding(.bottom)

            // Benefit + Message
            VStack(alignment: .leading){

                Text(benefitNumber)
                    .font(.title3)
                    .foregroundColor(customColor)
                    .fontWeight(.bold)

                Text(benefit)
                    .font(.title)
                    .fontWeight(.light)

                if subBenefit != "" {
                    Text(subBenefit)
                        .font(.callout)
                        .fontWeight(.light)
                }


            } //: VSTACK
            .padding(.top)

            Spacer()

            HStack{

                Spacer()

                // Image
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 260, height: 206, alignment: .center)
                    .padding(.bottom)
                    .padding(.leading)
                    .padding(.trailing)

                Spacer()

            } //: HSTACK
            .padding()


            Spacer()

            // Buttons
            HStack{

                Spacer()

                NavigationLink(destination: {
                    EmailView(firstName: "", lastName: "", login: true)
                }, label: {
                    Text("Login")
                        .font(.title3)
                        .fontWeight(.bold)
                        .modifier(StartButtonModifier())
                })
                .padding(.trailing, 20)

                Spacer()

                // Sign up button
                NavigationLink(destination: {
                    SignUpViewOne()
                }, label: {
                    Text("Sign Up")
                        .font(.title3)
                        .fontWeight(.bold)
                        .modifier(StartButtonModifier())
                })
                .padding(.leading, 20)

                Spacer()

            } //: HSTACK
            .padding()


            Spacer()

        } //: VSTACK
        .padding()


    } //: VIEW

}


// MARK: - PREVIEW 
//struct BenefitView_Previews: PreviewProvider {
//    static var previews: some View {
//        BenefitView()
//    }
//}

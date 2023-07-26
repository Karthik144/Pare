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

        if #available(iOS 16.0, *) {

            VStack(alignment: .leading, spacing: 10){

    //            // Header
    //            Text("Welcome to Pare")
    //                .font(.largeTitle)
    //                .fontWeight(.bold)
    //                .padding(.top)
    //                .padding(.bottom)

                // Benefit + Message
                VStack(alignment: .leading){

                    Text(benefitNumber)
                        .padding(.top)
                        .padding(.leading)
                        .font(.title3)
                        .foregroundColor(customColor)
                        .fontWeight(.bold)


                    Text(benefit)
                        .lineLimit(2)
                        .padding(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.title)
                        .fontWeight(.light)

                    if subBenefit != "" {
                        Text(subBenefit)
                            .padding(.leading)
                            .font(.callout)
                            .fontWeight(.light)
                    }


                } //: VSTACK
                .padding(.bottom)



                HStack{

                    Spacer()

                    // Image
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280, height: 226, alignment: .center)

                    Spacer()

                } //: HSTACK
                .padding()

                Spacer()

//
//                HStack{
//
//                    Spacer()
//
//
//
//                    if benefitNumber.contains("1"){
//
//                        // Circle Indexes
//                        HStack(spacing: 8){
//
//                            Circle()
//                                .foregroundColor(Color.gray)
//                                .frame(width: 7, height: 7)
//
//                            Circle()
//                                .fill(Color.gray.opacity(0.5))
//                                .frame(width: 7, height: 7)
//                        } //: HSTACK
//
//                    } else {
//
//                        // Circle Indexes
//                        HStack(spacing: 8){
//
//                            Circle()
//                                .fill(Color.gray.opacity(0.5))
//                                .frame(width: 7, height: 7)
//
//                            Circle()
//                                .foregroundColor(Color.gray)
//                                .frame(width: 7, height: 7)
//                        } //: HSTACK
//
//                    }
//
//
//                    Spacer()
//
//                } //: HSTACK
//                .padding()


    //            // Buttons
    //            HStack{
    //
    //                Spacer()
    //
    //                NavigationLink(destination: {
    //                    EmailView(firstName: "", lastName: "", login: true)
    //                }, label: {
    //                    Text("Login")
    //                        .font(.title3)
    //                        .fontWeight(.bold)
    //                        .modifier(StartButtonModifier())
    //                })
    //                .padding(.trailing, 20)
    //
    //                Spacer()
    //
    //                // Sign up button
    //                NavigationLink(destination: {
    //                    SignUpViewOne()
    //                }, label: {
    //                    Text("Sign Up")
    //                        .font(.title3)
    //                        .fontWeight(.bold)
    //                        .modifier(StartButtonModifier())
    //                })
    //                .padding(.leading, 20)
    //
    //                Spacer()
    //
    //            } //: HSTACK
    //            .padding()
    //
    //
//                Spacer()

            } //: VSTACK

        } else {

            VStack(alignment: .leading){

    //            // Header
    //            Text("Welcome to Pare")
    //                .font(.largeTitle)
    //                .fontWeight(.bold)
    //                .padding(.top)
    //                .padding(.bottom)

                // Benefit + Message
                VStack(alignment: .leading){

                    Text(benefitNumber)
                        .padding(.leading)
                        .font(.title3.weight(.bold))
                        .foregroundColor(customColor)


                    Text(benefit)
                        .padding(.leading)
                        .font(.title.weight(.light))

                    if subBenefit != "" {
                        Text(subBenefit)
                            .padding(.leading)
                            .font(.callout.weight(.light))
                    }


                } //: VSTACK

                Spacer()

                HStack{

                    Spacer()

                    // Image
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 260, height: 206, alignment: .center)

                    Spacer()

                } //: HSTACK


                Spacer()

    //            // Buttons
    //            HStack{
    //
    //                Spacer()
    //
    //                NavigationLink(destination: {
    //                    EmailView(firstName: "", lastName: "", login: true)
    //                }, label: {
    //                    Text("Login")
    //                        .font(.title3)
    //                        .fontWeight(.bold)
    //                        .modifier(StartButtonModifier())
    //                })
    //                .padding(.trailing, 20)
    //
    //                Spacer()
    //
    //                // Sign up button
    //                NavigationLink(destination: {
    //                    SignUpViewOne()
    //                }, label: {
    //                    Text("Sign Up")
    //                        .font(.title3)
    //                        .fontWeight(.bold)
    //                        .modifier(StartButtonModifier())
    //                })
    //                .padding(.leading, 20)
    //
    //                Spacer()
    //
    //            } //: HSTACK
    //            .padding()
    //
    //
    //            Spacer()

            } //: VSTACK


        }



    } //: VIEW

}


// MARK: - PREVIEW 
//struct BenefitView_Previews: PreviewProvider {
//    static var previews: some View {
//        BenefitView()
//    }
//}

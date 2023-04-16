//
//  Step1Onboarding1View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/14/23.
//

import SwiftUI

struct Step1Onboarding1View: View {

    // MARK: - PROPERTIES
    @Binding var isActive: Bool

    // MARK: - BODY
    var body: some View {

        if #available(iOS 16.0, *) {
            VStack{


                VStack {
                    HStack{
                        Text("Step 1 - Set up your wallet")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .padding(.bottom, 0)

                        Spacer()

                    } //: HSTACK

                    HStack{

                        Text("Think of your wallet like Venmo. You can load money into it.")
                            .font(.title3)
                            .padding()

                        Spacer()

                    } //: HSTACK


                    HStack{

                        Text("When you load money into it, you're purchasing a stable coin called USDC. Each USDC coin is equal to $1.")
                            .font(.title3)
                            .padding()

                        Spacer()


                    } //: HSTACK

                    HStack{

                        Text("It's like digital cash and it allows us to offer you the higest rewards and the lowest prices.")
                            .font(.title3)
                            .padding()

                        Spacer()

                    } //: HSTACK

                    HStack{

                        Text("Once you set up your wallet and load money into it, you can start spending on Pare and earning rewards.")
                            .font(.title3)
                            .padding()

                        Spacer()
                    }



                } //: VSTACK


                Spacer()

                NavigationLink(destination: Step1Onboarding2View(isViewActive: $isActive)) {
                    Text("Get started")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .frame(width: 300, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: 300, height: 50)
                        )
                }
                .padding()

                Spacer()


            } //: VSTACK
            .toolbar(.hidden, for: .tabBar)
        } else {
            // Fallback on earlier versions

            VStack{


                VStack {
                    HStack{
                        Text("Step 1 - Set up your wallet")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .padding(.bottom, 0)

                        Spacer()

                    } //: HSTACK

                    HStack{

                        Text("Think of your wallet like Venmo. You can load money into it.")
                            .font(.title3)
                            .padding()

                        Spacer()

                    } //: HSTACK


                    HStack{

                        Text("When you load money into it, you're purchasing a stable coin called USDC. Each USDC coin is equal to $1.")
                            .font(.title3)
                            .padding()

                        Spacer()


                    } //: HSTACK

                    HStack{

                        Text("It's like digital cash and it allows us to offer you the higest rewards and the lowest prices.")
                            .font(.title3)
                            .padding()

                        Spacer()

                    } //: HSTACK

                    HStack{

                        Text("Once you set up your wallet and load money into it, you can start spending on Pare and earning rewards.")
                            .font(.title3)
                            .padding()

                        Spacer()
                    }



                } //: VSTACK


                Spacer()

                NavigationLink(destination: Step1Onboarding2View(isViewActive: $isActive)) {
                    Text("Get started")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .frame(width: 300, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: 300, height: 50)
                        )
                }
                .padding()

                Spacer()


            } //: VSTACK

        } //: ELSE 



    }
}


// MARK: - PREVIEW
//struct Step1Onboarding1View_Previews: PreviewProvider {
//    static var previews: some View {
//        Step1Onboarding1View()
//    }
//}

//
//  PopUpView.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/8/23.
//

import SwiftUI
import MagicSDK_Web3

struct PopUpView: View {

    // MARK: - PROPERTIES
    @Binding var text: String
    let title: String
    let subTitle: String
    let promoCodePopup: Bool
    @ObservedObject var keyboardResponder = KeyboardResponder()
    @EnvironmentObject var walletViewModel: WalletViewModel

    let didClose: () -> Void 

    // MARK: - BODY
    var body: some View {

        VStack{

            VStack{

                HStack{

                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()

                    Spacer()

                }

                HStack{

                    Text(subTitle)
                        .lineLimit(3)
                        .foregroundColor(Color.gray)
                        .padding(.leading)

                    Spacer()
                }

            }


            if #available(iOS 16.0, *) {
                TextField("Instructions", text: $text, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            } else {
                // Fallback on earlier versions
                TextField("Instructions", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }

            if promoCodePopup && walletViewModel.userTokenBalance == 0 {

                Text("To use code, please add $30 to wallet. This won't be spent on this transaction.")
                    .foregroundColor(Color.red)
                    .padding()
            }
            

            Button {
                didClose()
            } label: {
                Text("Add")
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color(red: 0.167, green: 0.29, blue: 0.933))
                            .frame(width:100, height: 50)
                    )
                    .padding()
            }


        } //: VSTACK
        //.offset(y: -200)
        .offset(y: -keyboardResponder.currentHeight * 0.1)
        .frame(maxWidth: .infinity, maxHeight: 500)
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
        .background(background)
        .overlay(alignment: .topTrailing){
            close 
        }
        .transition(.move(edge: .bottom))
        .ignoresSafeArea()
    }
}

private extension PopUpView {

    var background: some View {

        RoundedCorners(color: .white, tl: 18, tr: 18, bl: 0, br: 0)
            .shadow(color: .black.opacity(0.2), radius: 3)
    }

    var close: some View {

        Button {

            text = ""
            // Close popup view
            didClose()

        } label: {

            Image(systemName: "xmark")
                .symbolVariant(.circle.fill)
                .font(

                    .system(size: 35, weight: .bold, design: .rounded)

                )
                .foregroundStyle(.gray.opacity(0.4))
                .padding(8)
        }

    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            Path { path in

                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)

                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}

// MARK: - PREVIEW
//struct PopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpView()
//            .padding()
//            .background(.blue)
//            .previewLayout(.sizeThatFits)
//    }
//}

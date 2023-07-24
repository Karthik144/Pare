//
//  ShopCell.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI
import Kingfisher

struct ShopCell: View {

    // MARK: - PROPERTIES
    let locationManager = LocationManager()
    let shop: Shop
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    @State var date: String?
    @State var dayOfWeek: Int?
    var closingTime = "22:00"
    var openingTime = "11:00"
    var sundayOpen = "12:00"
    
    @State var actualDistance: Double?


    // MARK: - BODY
    var body: some View {

        VStack(spacing: 10){

            HStack{
                Text(shop.name)
                    .font(.title3)
                    .foregroundColor(Color.black)
                Spacer()
            }
            .padding(.leading, 15)

            HStack{

                Text(shop.type)
                    .font(.callout)
                    .foregroundColor(Color.white)
                    .background(
                        Capsule()
                            .foregroundColor(Color.green)
                            .frame(width: 51, height: 21)
                    )

                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.black)
                    Text(shop.rating)
                        .foregroundColor(Color.black)
                } //: HStack
                .padding(.leading, 10)

                Spacer()

            } //: HSTACK
            .padding(.leading, 20)



            HStack{
                
                //General Closed Conditions
                
                if((dayOfWeek ?? 0) == 7 || (date ?? "" > closingTime) || (date ?? "" < openingTime) ){
                    Text("Closed")
                        .foregroundColor(Color.red)
                }
                else if((dayOfWeek ?? 0) == 1 && (date ?? "" > closingTime) && (date ?? "" < sundayOpen) ){
                    Text("Closed")
                        .foregroundColor(Color.red)
                }
                else{
                    Text("Open Now")
                        .foregroundColor(Color.gray)
                }
                

                Circle()
                    .frame(width: 2, height: 2)
                    .foregroundColor(Color.gray)

            
                Text(String(round((actualDistance ?? 0.0) * 100) / 100.0) + " miles")
                    .foregroundColor(Color.gray)

                Spacer()
            } //: HSTACK
            .padding(.leading, 20)

        } //: VSTACK
        .onAppear(){
            dateFormatter.dateFormat = "HH:mm"
            date = dateFormatter.string(from: Date())
            dayOfWeek = calendar.component(.weekday, from: Date())
            locationManager.updateLocation()
            locationManager.getDistance { distance in
                if let distance = distance {
                    actualDistance = distance
                    // Use the distance value here
                } else {
                    print("Distance is nil")
                    // Handle nil case here
                }
            }

        } //: ON APPEAR

    } //: VIEW
}

//struct ShopCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopCell()
//    }
//}

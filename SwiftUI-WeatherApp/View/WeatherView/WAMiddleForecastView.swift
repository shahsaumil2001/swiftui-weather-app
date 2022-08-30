//
//  WAMiddleForecastView.swift
//  SwiftUI-WeatherApp
//
//   
//

import SwiftUI

struct WAMiddleForecastView: View {

    var cityForecast: [Forecast]

    var body: some View {
        ZStack {

            // Background blur Rectangle View
            Rectangle()
                .foregroundColor(.black.opacity(0.3))
                .cornerRadius(10)
                .blur(radius: 2)
                .padding([.leading, .trailing], 10)

            VStack(alignment: .leading) {
                HStack {

                    // Header Icon
                    Image(systemName: Images.calendar)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 5, height: 5, alignment: .leading)

                    // Header Text
                    Text(StringConstant.fiveDaysForecast)
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                        .shadow(radius: 5)

                }
                .padding([.leading, .trailing], 26)
                .padding(.bottom, 4)
                .padding(.top)

                // Header Seperator
                Rectangle().frame(height: CGFloat(1))
                    .foregroundColor(.white.opacity(0.3))
                    .padding([.leading, .trailing], 16)

                // Scroll View
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(cityForecast) { dataObject in
                            Spacer().frame(width: 8)

                            // Forecast Cell
                            WAForecastCell(dataObject: dataObject)

                            // Seperator between cell in Forecast
                            fetchView(dataObject: dataObject)
                            Spacer().frame(width: 8)
                        }
                    }
                }.frame(height: 200)
            }
        }
        .padding([.leading, .trailing], 8)
        .padding(.top, 10)
    }

    ///
    /// The func is `fetchView` returns Seperator between cell in Forecast
    ///  A WAMiddleForecastView's `fetchView` method
    ///
       @ViewBuilder
    func fetchView(dataObject: Forecast) -> some View {

        // Returns seperator for all index accept last index

        if dataObject != cityForecast.last {
            Rectangle().frame(height: CGFloat(1))
                .foregroundColor(.white.opacity(0.3))
                .padding([.leading, .trailing], 16)
        } else {
            Spacer(minLength: 10)
        }
    }
}

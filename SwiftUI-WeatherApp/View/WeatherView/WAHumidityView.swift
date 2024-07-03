//
//  WAHumidityView.swift
//  SwiftUI-WeatherApp
//
//   
//

import SwiftUI

struct WAHumidityView: View {

    // MARK: - variables
    var todayForecast: Forecast

    var body: some View {
        ZStack {

            // Background blur Rectangle View
            Rectangle()
                .foregroundColor(.black.opacity(0.3))
                .cornerRadius(10)
                .blur(radius: 2)
                .padding([.leading, .trailing], 10)
            HStack {
                // Humidity Icon
                Image(systemName: Images.humidity)
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 5, height: 5, alignment: .leading)

                // Humidity
                Text("\(StringConstant.humidity)\(self.todayForecast.humidity)\(KeyConstants().percentage)")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.leading, 15)
                    .shadow(radius: 5)
            }
            .padding([.leading, .trailing], 26)
            .padding([.top, .bottom])
        }
        .padding([.leading, .trailing], 8)
        .padding(.top, 10)
    }
}

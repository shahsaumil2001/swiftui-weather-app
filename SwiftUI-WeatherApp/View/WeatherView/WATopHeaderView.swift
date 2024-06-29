//
//  TopHeaderView.swift
//  SwiftUI-WeatherApp
//
//   
//

import SwiftUI

struct WATopHeaderView: View {

    // MARK: - variables
    var city: String
    var todayForecast: Forecast

    var body: some View {
        VStack {
            // City name
            Text(city)
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .shadow(radius: 5)

            // Temperature
            Text("\(Int(todayForecast.temperature))\(KeyConstants().celsius)")
                .font(.system(size: 86))
                .fontWeight(.thin)
                .foregroundColor(.white)
                .shadow(radius: 5)

            // Weather description
            Text(todayForecast.description.capitalized)
                .font(.title2)
                .fontWeight(.medium)
                .padding(.bottom, 4)
                .foregroundColor(.white)
                .shadow(radius: 5)

            // Date
            Text("\(StringConstant.high)\(Int(todayForecast.highTemperature))\(KeyConstants().celsius)   \(StringConstant.low)\(Int(todayForecast.lowTemperature))\(KeyConstants().celsius)")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .shadow(radius: 5)
        }
    }
}

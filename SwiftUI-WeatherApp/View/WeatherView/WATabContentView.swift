//
//  TabContentView.swift
//  SwiftUI-WeatherApp
//
//   
//

import SwiftUI

struct WATabContentView: View {

    // MARK: - variables
    var city: String
    var cityDetail: City
    var cityForecast: [Forecast]
    var todayForecast: Forecast

    var body: some View {
        VStack {
            Spacer(minLength: 100)
            // Top Header View : City
            WATopHeaderView(city: city, todayForecast: todayForecast)

            // Middle Forecast View : 5 day Forecast from Today
            WAMiddleForecastView(cityForecast: cityForecast)

            // Sun Progress View : Sunrise & Sunset
            WASunProgressView(cityDetail: cityDetail)

            // Humidity View 
            WAHumidityView(todayForecast: todayForecast)
        }
    }
}

//
//  TabContentView.swift
//  SwiftUI-WeatherApp
//
//   
//

import SwiftUI

struct WATabContentView: View {

    // MARK: - variables
    var city: City
    var cityForecasts: [Forecast]
    var todayForecast: Forecast

    var body: some View {
        VStack {
            Spacer(minLength: 100)
            // Top Header View : City
            WATopHeaderView(cityName: city.cityName, todayForecast: todayForecast)

            // Middle Forecast View : 5 day Forecast from Today
            WAMiddleForecastView(cityForecasts: cityForecasts)

            // Sun Progress View : Sunrise & Sunset
            WASunProgressView(city: city)

            // Humidity View
            WAHumidityView(todayForecast: todayForecast)
        }
    }
}

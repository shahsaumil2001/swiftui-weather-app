//
//  WAForecastCell.swift
//  SwiftUI-WeatherApp
//
//   
//

import SwiftUI

struct WAForecastCell: View {

    // MARK: - variables
    var forecast: Forecast

    var body: some View {
        HStack {
            // Date
            Text(Date().convertToForecastDate(dateInStr: forecast.date, expecxtedDateFormat: DateFormat.day.rawValue) ?? "")
                .padding(.leading)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .shadow(radius: 5)
            Spacer(minLength: 10)

            // Hour
            Text(Date().convertToForecastDate(dateInStr: forecast.date, expecxtedDateFormat: DateFormat.time.rawValue) ?? "")
                .padding(.leading)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .shadow(radius: 5)
            Spacer(minLength: 10)

            // Icon
            Image(forecast.image)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.leading)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .shadow(radius: 5)
            Spacer(minLength: 10)

            // Temperature
            Text("\(Int(forecast.temperature))\(KeyConstants().celsius)")
                .padding(.leading)
                .padding(.trailing, 30)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .shadow(radius: 5)
        }
        .padding([.top, .bottom], -8)
        .padding(.leading, 10)
    }
}

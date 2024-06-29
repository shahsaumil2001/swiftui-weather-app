//
//  WAForecastCell.swift
//  SwiftUI-WeatherApp
//
//   
//

import SwiftUI

struct WAForecastCell: View {

    // MARK: - variables
    var dataObject: Forecast

    var body: some View {
        HStack {
            // Date
            Text(Date().convertToForecastDate(dateInStr: dataObject.date, expecxtedDateFormat: DateFormat.day.rawValue) ?? "")
                .padding(.leading)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .shadow(radius: 5)
            Spacer(minLength: 10)

            // Hour
            Text(Date().convertToForecastDate(dateInStr: dataObject.date, expecxtedDateFormat: DateFormat.time.rawValue) ?? "")
                .padding(.leading)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .shadow(radius: 5)
            Spacer(minLength: 10)

            // Icon
            Image(dataObject.image)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.leading)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .shadow(radius: 5)
            Spacer(minLength: 10)

            // Temperature
            Text("\(Int(dataObject.temperature))\(KeyConstants().celsius)")
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

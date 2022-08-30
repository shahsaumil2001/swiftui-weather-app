//
//  Forecast.swift
//  SwiftUI-WeatherApp
//
//  Created by Saumil Shah on 26/07/22.
//

import SwiftUI
import SwiftyJSON

struct Forecast: Identifiable, Equatable {
    var id: Double
    var date: String
    var time: Int
    var temperature: Double
    var highTemperature: Double
    var lowTemperature: Double
    var humidity: Int
    var mainDescription: String
    var description: String
    var image: String

    init(json: JSON) {
        self.id = json[APIKey.dtKey].double ?? 00
        // Date & Time
        self.date = json[APIKey.dtTxt].string ?? ""
        self.time = json[APIKey.dtKey].int ?? 0
        // Temperature
        let main = json[APIKey.main].dictionaryValue
        let kelvinTemp = main[APIKey.temp]?.double ?? 00.00
        let celsiusTemp = kelvinTemp - 273.15
        self.temperature = celsiusTemp
        // High Temperature
        let maxKelvinTemp = main[APIKey.tempMax]?.double ?? 00.00
        let maxCelsiusTemp = maxKelvinTemp - 273.15
        self.highTemperature = maxCelsiusTemp
        // Low Temperature
        let minKelvinTemp = main[APIKey.tempMin]?.double ?? 00.00
        let minCelsiusTemp = minKelvinTemp - 273.15
        self.lowTemperature = minCelsiusTemp
        // Humidity
        self.humidity = main[APIKey.humidity]?.intValue ?? 0
        // Icon
        let weatherArr = json[APIKey.weather].array ?? []
        var weatherDesc = "", weatherIcon = "", mainDesc = ""
        for weather in weatherArr where weatherArr.count > 0 {
            mainDesc = weather[APIKey.main].stringValue
            weatherDesc = weather[APIKey.description].stringValue
            weatherIcon = weather[APIKey.icon].stringValue
        }
        self.mainDescription = mainDesc
        self.description = weatherDesc
        self.image = weatherIcon
    }
}

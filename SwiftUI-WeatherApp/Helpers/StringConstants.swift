//
//  StringConstants.swift
//  SwiftUI-WeatherApp
//
//   
//

import Foundation
struct KeyConstants {
    // Add weather key and url here
    let apiBaseUrl = ""
    let appKey = ""
    // Sydney
    let city1Lat = "-33.8688"
    let city1Long = "151.2093"
    let json = "json"
    let celsius = "°C"
    let percentage = " %"
    let gifExtension = "gif"
    let twelveAM = "12 AM"
    let twelvePM = "12 PM"
    let fivePM = "5 PM"
}

struct APIKey {
    static let code = "cod"
    static let message = "message"
    static let list = "list"
    static let city = "city"
    static let dtKey = "dt"
    static let dtTxt = "dt_txt"
    static let main = "main"
    static let weather = "weather"
    static let temp = "temp"
    static let tempMin = "temp_min"
    static let tempMax = "temp_max"
    static let humidity = "humidity"
    static let id = "id"
    static let description = "description"
    static let icon = "icon"
    static let name = "name"
    static let country = "country"
    static let sunrise = "sunrise"
    static let sunset = "sunset"
}

struct Images {
    static let sky = "sky"
    static let humidity = "humidity.fill"
    static let calendar = "calendar"
    static let sun = "sun.max.fill"
}

struct GIF {
    static let rainfall = "Rainfall"
    static let cloudSky = "CloudSky"
    static let nightSky = "NightSky"
}

struct StringConstant {
    static let noInternetConnection = "The Internet connection appears to be offline."
    static let somethingWentWrong = "Something went wrong."
    static let okText = "OK"
    static let live = "Live"
    static let loading = "Loading..."
    static let fiveDaysForecast = "5-DAY FORECAST"
    static let sunriseAndSunset = "SUNRISE & SUNSET"
    static let humidity = "Humidity   "
    static let high = "H:"
    static let low = "L:"
}

enum Description: String {
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case showerRain = "shower rain"
    case rain = "rain"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case thunderstorm = "thunderstorm"
    case snow = "snow"
    case mist = "mist"
}

enum MainDescription: String {
    case cloud = "Clouds"
    case rain = "Rain"
    case clearSky = "Clear"
}

//
//  City.swift
//  SwiftUI-WeatherApp
//
//  Created by Saumil Shah on 26/07/22.
//

import SwiftyJSON

struct City: Decodable {
    static let preview = City(code: "", message: "", list: [], city: [:], cityName: "", sunset: 0, sunrise: 0)

    var code: String
    var message: String
    var list: [Forecast]
    var city: [String: JSON]
    let cityName: String
    let sunset: Int
    let sunrise: Int
}

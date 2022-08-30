//
//  City.swift
//  SwiftUI-WeatherApp
//
//  Created by Saumil Shah on 26/07/22.
//

import SwiftUI
import SwiftyJSON

public struct City {

    var code: String
    var message: String
    var list: [Forecast] = []
    var city: [String: JSON]
    var cityName: String
    let sunset: Int
    let sunrise: Int

    init(json: JSON) {
        self.code = json[APIKey.code].string ?? ""
        self.message = json[APIKey.message].string ?? ""
        self.city = json[APIKey.city].dictionaryValue
        self.cityName = self.city[APIKey.name]?.string ?? "sydney"
        let listData = json[APIKey.list].arrayValue
        for list in listData where listData.count > 0 {
            let listObject = Forecast(json: list)
            self.list.append(listObject)
        }
        self.sunset = self.city[APIKey.sunset]?.intValue ?? 0
        self.sunrise = self.city[APIKey.sunrise]?.intValue ?? 0
    }
}

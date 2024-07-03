//
//  WeatherViewModel.swift
//  SwiftUI-WeatherApp
//
//   
//

import Alamofire
import SwiftyJSON
import Combine

class WeatherViewModel: ObservableObject {

    // MARK: - Properties
    // Local variables
    var city: City = .preview
    var cities = [City]()
    // Published array
    @Published var cityNames = [String]()
    @Published var todayForacasts = [Forecast]()
    @Published var cityForecasts = [Forecast]()
    @Published var weatherDescriptions = [String]()
    // Published variable
    @Published var stateView: StateView = StateView.loading
    @Published var selectedForecastDescription = ""

    // MARK: - Functions
    ///
    /// The func is `createAPIUrl` returns API URL
    ///  A WeatherViewModel's `createAPIUrl` method
    ///
    func createAPIUrl(lat: String, long: String) -> String {
        return KeyConstants().apiBaseUrl + "?lat=\(lat)&lon=\(long)&appid=\(KeyConstants().appKey)"
    }

    ///
    /// The func is `createTodayForecastList` creates TodayForecastList
    ///  A WeatherViewModel's `createTodayForecastList` method
    ///
    func createTodayForecastList() {
        self.todayForacasts.removeAll()
        for index in 0..<self.cities.count where self.cities.count > 0 {
            let dataObject = self.cities[index]
            for weatherIndex in 0..<dataObject.list.count where weatherIndex % 40 == 0 {
                self.todayForacasts.append(dataObject.list[weatherIndex])
                self.weatherDescriptions.append(dataObject.list[weatherIndex].mainDescription)
            }
        }
    }

    // MARK: - API
    ///
    /// The func is `getWeatherInformation` is used to Call
    ///  A WeatherViewModel's `getWeatherInformation` method
    ///
    func getWeatherInformation(lat: String, long: String) {
        if !NetworkManager().isReachable() {
            self.stateView = .noInternet
            return
        }
        let url = self.createAPIUrl(lat: lat, long: long)
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { [self] (response) in
            switch response.result {
            case .success(let data):
                do {
                    guard let data = data else {
                        self.city.message = StringConstant.somethingWentWrong
                        self.stateView = .failed
                        return
                    }
                    // decode JSON
                    self.city = try JSONDecoder().decode(City.self, from: data)
                    self.cities.append(self.city)
                    self.cityNames.removeAll()
                    self.cityForecasts.removeAll()
                    for data in self.cities where self.cities.count > 0 {
                        // Fill cityNames
                        self.cityNames.append(data.cityName)
                        // Fill cityForecastList
                        self.cityForecasts.append(contentsOf: data.list)
                    }

                    // Fill todayForecastList
                    self.createTodayForecastList()

                    // Status code will be 200 then show data
                    if Int(self.city.code) == 200 {
                        self.stateView = .success
                    } else {
                        // Status code other than 200 then show error
                        self.stateView = .failed
                    }

                } catch let error as NSError {
                    // handle error here
                    self.city.message = error.localizedDescription
                    self.stateView = .failed
                    debugPrint("Failed to load: \(error.localizedDescription)")
                }
            case .failure(let error):
                // handle error here
                self.city.message = error.isSessionTaskError ? StringConstant.weatherKeyMissing : error.localizedDescription
                self.stateView = .failed
                debugPrint("Failed to load: \(error.localizedDescription)")
            }
        })
    }
}

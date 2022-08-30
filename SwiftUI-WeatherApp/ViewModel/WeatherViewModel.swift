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
    var apiResponse = City(json: JSON())
    var mainArray = [City]()
    // Published array
    @Published var cityNameList = [String]()
    @Published var todayForacast = [Forecast]()
    @Published var cityForecastList = [Forecast]()
    @Published var weatherDescriptionList = [String]()
    // Published variable
    @Published var stateView: StateView = StateView.loading
    @Published var selectedForecastDescription = ""

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
        self.todayForacast.removeAll()
        for index in 0..<self.mainArray.count where self.mainArray.count > 0 {
            let dataObject = self.mainArray[index]

            for weatherIndex in 0..<dataObject.list.count where weatherIndex % 40 == 0 {
                self.todayForacast.append(dataObject.list[weatherIndex])
                self.weatherDescriptionList.append(dataObject.list[weatherIndex].mainDescription)
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
                        self.apiResponse.message = StringConstant.somethingWentWrong
                        self.stateView = .failed
                        return
                    }
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        let jsonObject = JSON(json)
                        self.apiResponse = City(json: jsonObject)
                        self.mainArray.append(self.apiResponse)

                        self.cityNameList.removeAll()
                        self.cityForecastList.removeAll()
                        for data in self.mainArray where self.mainArray.count > 0 {
                            // Fill cityNameList
                            self.cityNameList.append(data.cityName)

                            // Fill cityForecastList
                            self.cityForecastList.append(contentsOf: data.list)
                        }

                        // Fill todayForecastList
                        self.createTodayForecastList()

                        // Status code will be 200 then show data
                        if Int(self.apiResponse.code) == 200 {
                            self.stateView = .success
                        } else {
                            // Status code other than 200 then show error
                            self.stateView = .failed
                        }
                    }
                } catch let error as NSError {
                    // handle error here
                    self.apiResponse.message = error.localizedDescription
                    self.stateView = .failed
                    print("Failed to load: \(error.localizedDescription)")
                }
            case .failure(let error):
                // handle error here
                self.apiResponse.message = error.localizedDescription
                self.stateView = .failed
                print("Failed to load: \(error.localizedDescription)")
            }
        })
    }
}

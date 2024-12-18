//
//  WAWeatherView.swift
//  SwiftUI-WeatherApp
//
//   
//

import SwiftUI

struct WAWeatherView: View {

    // MARK: - variables
    @Binding var viewModel: WeatherViewModel

    // MARK: - functions
    ///
    /// The func is `getCityForecast` returns ForecastList for City
    ///  A WAWeatherView's `getCityForecast` method
    ///
    func getCityForecast(index: Int) -> [Forecast] {
        var temperatures = [Forecast]()
        // For first index append object in Array
        if index == 0 {
            for indexVal in 0..<self.viewModel.cityForecasts.count {
                while indexVal < 40 {
                    temperatures.append(self.viewModel.cityForecasts[indexVal])
                    break
                }
            }
        } else {
            let previousIndex = 40 * index, nextIndex = 40 * (index + 1)
            // Append objects in 40 slots like 1...40, 41...80, 81...120
            for indexVal in previousIndex..<self.viewModel.cityForecasts.count {
                while indexVal <= nextIndex {
                    temperatures.append(self.viewModel.cityForecasts[indexVal])
                    break
                }
            }
        }
        return temperatures
    }

    var body: some View {
        ZStack {
            LazyVStack {
                // Pagination
                TabView {
                    ForEach(0..<self.viewModel.cityNames.count, id: \.self) { index in
                        // ScrollView
                        ScrollView(showsIndicators: false) {
                            ZStack {
                                Color.clear
                                // TabContent View
                                WATabContentView(city: self.viewModel.cities[index],
                                                 cityForecasts: getCityForecast(index: index), todayForecast: self.viewModel.todayForacasts[index])
                                .onAppear {
                                    // Set current index's description in ViewModel
                                    self.viewModel.selectedForecastDescription =  self.viewModel.todayForacasts[index].mainDescription
                                }
                            }
                        }
                    } .padding(.all, 10)
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .offset(y: -30)
            }
        }
    }
}

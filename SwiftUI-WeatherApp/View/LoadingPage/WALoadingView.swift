//
//  ContentView.swift
//  SwiftUI-WeatherApp
//
//  Created by Saumil Shah on 26/07/22.
//

import SwiftUI

struct WALoadingView: View {

    @ObservedObject var viewModel = WeatherViewModel()

    var body: some View {
        ZStack {
            // Background View
            WABackgroundView(viewModel: .constant(self.viewModel))
            LazyVStack {
                if viewModel.stateView  == .loading {
                    // Loading...
                    Text(StringConstant.loading)
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .bold))
                        .shadow(radius: 5)
                }

                if viewModel.stateView  == .success {
                    // WAWeatherView
                    WAWeatherView(viewModel:
                            .constant(self.viewModel))
                }

                if viewModel.stateView  == .noInternet {
                    // No Internet
                    Text(StringConstant.noInternetConnection)
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .bold))
                        .shadow(radius: 5)
                        .frame(width: 300, alignment: .center)
                }

                if viewModel.stateView == .failed {
                    // API Error Message
                    Text(viewModel.apiResponse.message)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .shadow(radius: 5)
                }
            }
        }.onAppear {
            // API Calling with City1 cooardinates
            self.viewModel.getWeatherInformation(lat: KeyConstants().city1Lat, long: KeyConstants().city1Long)
            // you can add City2 cooardinates if you want
            // self.viewModel.getWeatherInformation(lat: ..., long: ...)
        }
    }
}

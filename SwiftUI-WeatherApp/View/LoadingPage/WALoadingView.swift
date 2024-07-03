//
//  ContentView.swift
//  SwiftUI-WeatherApp
//
//  Created by Saumil Shah on 26/07/22.
//

import SwiftUI

struct WALoadingView: View {

    // MARK: - variables
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
                        .font(.system(size: 20, weight: .regular))
                        .shadow(radius: 5)
                        .frame(width: 300, alignment: .center)
                }

                if viewModel.stateView == .failed {
                    // API Error Message
                    VStack(alignment: .center, spacing: 5) {
                        // Error Image
                        Image(systemName: Images.error)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50, alignment: .center)
                            .padding(.bottom, 10)

                        // Error Title
                        Text(StringConstant.error)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular))
                            .shadow(radius: 5)
                            .multilineTextAlignment(.center)

                        // Error Description
                        Text(viewModel.city.message)
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 18, weight: .regular))
                            .shadow(radius: 5)
                            .multilineTextAlignment(.center)

                    }.padding(.horizontal, 20)
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

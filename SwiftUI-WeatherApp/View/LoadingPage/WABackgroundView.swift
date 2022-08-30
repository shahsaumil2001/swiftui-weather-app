//
//  BackgroundView.swift
//  SwiftUI-WeatherApp
//
//   
//

import SwiftUI
import SDWebImageSwiftUI

struct WABackgroundView: View {

    @Binding var viewModel: WeatherViewModel

    var body: some View {
        let url = Bundle.main.url(forResource: self.getBackgroundForForecast(), withExtension: KeyConstants().gifExtension)!
        let data = (try? Data(contentsOf: url)) ?? Data()
        // GIF
        AnimatedImage(data: data)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            .edgesIgnoringSafeArea(.all)
    }

    ///
    /// The func is `getBackgroundForForecast` returns GIF as per description
    ///  A WABackgroundView's `getBackgroundForForecast` method
    ///
    func getBackgroundForForecast() -> String {
        switch self.viewModel.selectedForecastDescription {
        case MainDescription.clearSky.rawValue:
            return GIF.nightSky
        case MainDescription.cloud.rawValue:
            return GIF.cloudSky
        case MainDescription.rain.rawValue:
            return GIF.rainfall
        default:
            return GIF.nightSky
        }
    }
}

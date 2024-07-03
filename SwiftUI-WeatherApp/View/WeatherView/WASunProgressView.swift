//
//  WASunProgressView.swift
//  SwiftUI-WeatherApp
//
//   
//

import SwiftUI

struct WASunProgressView: View {

    // MARK: - variables
    var city: City
    @State var progress: CGFloat = 0.0

    // MARK: - functions
    ///
    /// The func is `startLoading` initiates progress for Sunrise-Sunset Progressbar
    ///  A WASunDetailView's `startLoading` method
    ///
    func startLoading() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            withAnimation {
                self.progress += 0.01
                if self.progress >= self.giveTimeProgress() {
                    timer.invalidate()
                }
            }
        }
    }

    ///
    /// The func is `giveTimeProgress` returns progress as per current time
    ///  A WASunDetailView's `giveTimeProgress` method
    ///
    func giveTimeProgress() -> CGFloat {
        let currentTime = Date().hour()
        if currentTime < KeyConstants().twelveAM {
            return 0.25
        } else if currentTime == KeyConstants().twelvePM {
            return 0.50
        } else if currentTime > KeyConstants().twelvePM && currentTime < KeyConstants().fivePM {
            return 0.75
        } else {
            return 0.99
        }
    }

    var body: some View {
        ZStack {

            // Background blur Rectangle View
            Rectangle()
                .foregroundColor(.black.opacity(0.3))
                .cornerRadius(10)
                .blur(radius: 2)
                .padding([.leading, .trailing], 10)

            VStack(alignment: .leading) {
                HStack {
                    // Header Icon
                    Image(systemName: Images.sun)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 5, height: 5, alignment: .leading)

                    // Header Text
                    Text(StringConstant.sunriseAndSunset)
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                        .shadow(radius: 5)
                }
                .padding([.leading, .trailing], 26)
                .padding(.bottom, 4)
                .padding(.top)
                Spacer()

                // Header Seperator
                Rectangle().frame(height: CGFloat(1))
                    .foregroundColor(.white.opacity(0.3))
                    .padding([.leading, .trailing], 16)
                Spacer(minLength: 20)
                Spacer(minLength: 100)
                Rectangle().frame(height: CGFloat(0))
                    .padding([.leading, .trailing], 16)
                    .overlay {
                        ZStack {
                            // Dotted Half Circle
                            Circle()
                                .trim(from: 0.0, to: 0.5)
                                .stroke(Color.yellow.opacity(0.2), style: StrokeStyle(lineWidth: 5.0, dash: [3]))
                                .frame(width: 200, height: 200)
                                .rotationEffect(Angle(degrees: -180))
                                .shadow(radius: 5)

                            // Progress on dotted half circle
                            Circle()
                                .trim(from: 0.0, to: progress/2)
                                .stroke(Color.yellow.opacity(0.8), style: StrokeStyle(lineWidth: 5.0, dash: [3]))
                                .frame(width: 200, height: 200)
                                .rotationEffect(Angle(degrees: -180))
                                .shadow(radius: 5)
                        }
                        HStack {
                            Spacer()
                            // Sunrise yellow dot above time
                            Circle()
                                .frame(width: 10, height: 10, alignment: .leading)
                                .foregroundColor(.yellow)
                                .shadow(radius: 5)
                            Spacer(minLength: 188)
                            // Sunset yellow dot above time
                            Circle()
                                .frame(width: 10, height: 10, alignment: .trailing)
                                .foregroundColor(.yellow)
                                .shadow(radius: 5)
                            Spacer()
                        }
                    }
                HStack {
                    Spacer()
                    // Sunrise time
                    Text(city.sunrise.dateFromMilliseconds().hour())
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                        .shadow(radius: 5)
                    Spacer(minLength: 130)

                    // Sunset time
                    Text(city.sunset.dateFromMilliseconds().hour())
                        .padding(.leading)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                        .shadow(radius: 5)
                    Spacer()
                }
                Spacer(minLength: 20)
            }
        }
        .padding([.leading, .trailing], 8)
        .padding(.top, 10)
        .onAppear {
            self.startLoading()
        }
    }
}

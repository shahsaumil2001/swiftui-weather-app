//
//  Int+Extension.swift
//  SwiftUI-WeatherApp
//
//   
//

import Foundation

extension Int {
    func dateFromMilliseconds() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

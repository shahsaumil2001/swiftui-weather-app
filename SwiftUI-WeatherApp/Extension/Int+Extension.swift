//
//  Int+Extension.swift
//  SwiftUI-WeatherApp
//
//   
//

import Foundation

extension Int {
    ///
    /// The func is `dateFromMilliseconds` returns milli seconds of Date
    ///  extension Int's `dateFromMilliseconds` method
    ///
    func dateFromMilliseconds() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

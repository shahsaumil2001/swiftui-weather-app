//
//  Date+Extension.swift
//  SwiftUI-WeatherApp
//
//   
//

import Foundation

// DateFormat enum
enum DateFormat: String {
    case backendDate = "yyyy-MM-dd'T'HH:mm:ss.000'Z'"
    case localLongDate = "yyyy-MM-dd HH:mm:ss"
    case local = "dd MMM"
    case dateFormat = "MMM d, yyyy"
    case day = "EEE"
    case time = "h:mm a"
    case messageLongDate = "dd/MM hh:mm a"
}

extension Date {

    ///
    /// The func is `convertToForecastDate` will convert date to expected date format
    ///  extension Date's `convertToForecastDate` method
    ///
    func convertToForecastDate(dateInStr: String, expecxtedDateFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.localLongDate.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        if let date = dateFormatter.date(from: dateInStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = expecxtedDateFormat
            return dateFormatter.string(from: date)
        }
        return ""
    }

    ///
    /// The func is `hour` returns hour of date
    ///  extension Date's `hour` method
    ///
    func hour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: self)
    }

    ///
    /// The func is `dayMonthAndYear` returns day & month of date
    ///  extension Date's `dayMonthAndYear` method
    ///
    func dayMonthAndYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: self)
    }

    ///
    /// The func is `dayMonthly` returns date in 'dd MMM' format
    ///  extension Date's `dayMonthly` method
    ///
    func dayMonthly() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        return dateFormatter.string(from: self)
    }

    ///
    /// The func is `currentTime` returns date in 'h mm a' format
    ///  extension Date's `currentTime` method
    ///
    func currentTime() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "h mm a"
        guard let someDateTime = formatter.date(from: formatter.string(from: Date())) else { return Date() }
        return someDateTime
    }
}

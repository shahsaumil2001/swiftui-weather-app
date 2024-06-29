//
//  String+Extension.swift
//  SwiftUI-WeatherApp
//
//   
//

import Foundation

extension String {
    ///
    /// The func is `getStringBeforeSpace` returns first half of sub string divided by space
    ///  extension String's `getStringBeforeSpace` method
    ///
    func getStringBeforeSpace() -> String {
        let delimiter = " "
        let firstHalfOfString = self.components(separatedBy: delimiter)
        return firstHalfOfString[0]
    }
}

//
//  String+Extension.swift
//  SwiftUI-WeatherApp
//
//   
//

import Foundation

extension String {
    func getStringBeforeSpace() -> String {
        let delimiter = " "
        let firstHalfOfString = self.components(separatedBy: delimiter)
        return firstHalfOfString[0]
    }
}

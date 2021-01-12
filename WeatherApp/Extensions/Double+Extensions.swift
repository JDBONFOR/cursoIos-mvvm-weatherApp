//
//  Double+Extensions.swift
//  WeatherApp
//
//  Created by Juan Bonforti on 11/01/2021.
//

import Foundation

extension Double {
    var formatAsDegree: String {
        return String(format: "%.0f°", self)
    }
}

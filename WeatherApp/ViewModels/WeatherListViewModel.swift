//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by Juan Bonforti on 11/01/2021.
//

import Foundation

struct WeatherListViewModel {
    private var weatherCityViewModel = [WeatherCityViewModel]()
    
    mutating func addWeatherViewModel(_ viewModel: WeatherCityViewModel) {
        self.weatherCityViewModel.append(viewModel)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.weatherCityViewModel.count
    }
    
    func modelAt(_ indexPath: Int) -> WeatherCityViewModel {
        return weatherCityViewModel[indexPath]
    }
}

struct WeatherCityViewModel: Decodable {
    let name: String
    let currentTemperature: WeatherCityMainViewModel
    
    private enum CodingKeys: String, CodingKey {
        case name
        case currentTemperature = "main"
    }
}

struct WeatherCityMainViewModel: Decodable {
    let temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}

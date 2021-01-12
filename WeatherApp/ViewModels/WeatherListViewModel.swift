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
    
    mutating private func toCelsius() {
        weatherCityViewModel = weatherCityViewModel.map { viewModel in
            var weatherModel = viewModel
            weatherModel.currentTemperature.temperature = (weatherModel.currentTemperature.temperature - 32) * 5/9
            return weatherModel
        }
    }
    
    mutating private func toFahrenheit() {
        weatherCityViewModel = weatherCityViewModel.map { viewModel in
            var weatherModel = viewModel
            weatherModel.currentTemperature.temperature = (weatherModel.currentTemperature.temperature * 9/5) + 32
            return weatherModel
        }
    }
    
    mutating func updateUnit(to unit: Unit) {
        
        switch unit {
        case .celsius:
            toCelsius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
}

struct WeatherCityViewModel: Decodable {
    let name: String
    var currentTemperature: WeatherCityMainViewModel
    
    private enum CodingKeys: String, CodingKey {
        case name
        case currentTemperature = "main"
    }
}

struct WeatherCityMainViewModel: Decodable {
    var temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}

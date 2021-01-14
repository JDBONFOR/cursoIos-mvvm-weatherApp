//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by Juan Bonforti on 11/01/2021.
//

import Foundation

class WeatherListViewModel {
    
    private(set) var weatherCityViewModel = [WeatherCityViewModel]()
    
    func addWeatherViewModel(_ viewModel: WeatherCityViewModel) {
        self.weatherCityViewModel.append(viewModel)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.weatherCityViewModel.count
    }
    
    func modelAt(_ indexPath: Int) -> WeatherCityViewModel {
        return weatherCityViewModel[indexPath]
    }
    
    private func toCelsius() {
        weatherCityViewModel = weatherCityViewModel.map { viewModel in
            let weatherModel = viewModel
            weatherModel.currentTemperature.temperature.value = (weatherModel.currentTemperature.temperature.value - 32) * 5/9
            return weatherModel
        }
    }
    
    private func toFahrenheit() {
        weatherCityViewModel = weatherCityViewModel.map { viewModel in
            let weatherModel = viewModel
            weatherModel.currentTemperature.temperature.value = (weatherModel.currentTemperature.temperature.value * 9/5) + 32
            return weatherModel
        }
    }
    
    func updateUnit(to unit: Unit) {
        
        switch unit {
        case .celsius:
            toCelsius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
}

// Type Eraser
class Dynamic<T>: Decodable where T: Decodable {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
    
}


struct WeatherCityViewModel: Decodable {
    let name: Dynamic<String>
    var currentTemperature: WeatherCityMainViewModel
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = Dynamic(try container.decode(String.self, forKey: .name))
        currentTemperature = try container.decode(WeatherCityMainViewModel.self, forKey: .currentTemperature)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case currentTemperature = "main"
    }
}

struct WeatherCityMainViewModel: Decodable {
    var temperature: Dynamic<Double>
    var temperatureMin: Dynamic<Double>
    var temperatureMax: Dynamic<Double>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
        temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
        temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax))
    }
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}

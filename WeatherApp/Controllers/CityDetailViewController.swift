//
//  CityDetailViewController.swift
//  WeatherApp
//
//  Created by Juan Bonforti on 14/01/2021.
//

import Foundation
import UIKit

class CityDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    
    // MARK: - Vars
    var viewModel: WeatherCityViewModel?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVMBindings()
    }
    
}

// MARK: - Extension
extension CityDetailViewController {
    
    func setupVMBindings() {
        if let viewModel = viewModel {
            viewModel.name.bind { self.cityNameLabel.text = $0 }
            viewModel.currentTemperature.temperature.bind { self.currentTemperature.text = $0.formatAsDegree }
        }
        
        // Change the value after few seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.viewModel?.name.value = "Boston"
        }
    }
}

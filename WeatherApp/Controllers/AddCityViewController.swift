//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Juan Bonforti on 11/01/2021.
//

import Foundation
import UIKit

protocol AddCityDelegate {
    func addWeatherDidSave(viewModel: WeatherCityViewModel)
}

class AddCityViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cityTextField: BindingTextField! {
        didSet {
            cityTextField.bind { self.viewModel.city = $0 }
        }
    }
    @IBOutlet weak var stateTextField: BindingTextField! {
        didSet {
            stateTextField.bind { self.viewModel.state = $0 }
        }
    }
    @IBOutlet weak var zipCodeTextField: BindingTextField! {
        didSet {
            zipCodeTextField.bind { self.viewModel.zipCode = $0 }
        }
    }
    
    // MARK: - Vars
    var delegate: AddCityDelegate?
    var viewModel = AddCityViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func saveButtonAction(_ sender: Any) {
        
        print(viewModel)
        
        if let city = cityTextField.text {
            
            let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=8861e65927df02c1122b1fefb6acbd14&units=imperial")!
            
            let weatherResource = Resource<WeatherCityViewModel>(url: weatherUrl) { data in
                let weatherViewModel = try? JSONDecoder().decode(WeatherCityViewModel.self, from: data)
                return weatherViewModel
            }
            
            Webservice().load(resource: weatherResource) { [weak self] result in
                
                if let result = result {
                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(viewModel: result)
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
            
        }
                
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Extension

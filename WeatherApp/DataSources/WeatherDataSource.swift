//
//  WeatherDataSource.swift
//  WeatherApp
//
//  Created by Juan Bonforti on 14/01/2021.
//

import Foundation
import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
    
    private let cellIdentifier: String
    private let viewModel: WeatherListViewModel
    
    init(cellIdentifier: String, viewModel: WeatherListViewModel) {
        self.cellIdentifier = cellIdentifier
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherCityViewModel.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? WeatherCell else { fatalError("Cell not found") }
        let weatherVM = viewModel.modelAt(indexPath.row)
        
        cell.setupCell(weatherVM)
        
        return cell
        
    }
    
}

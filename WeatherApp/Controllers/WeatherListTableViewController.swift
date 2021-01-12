//
//  WeatherListTableViewController.swift
//  WeatherApp
//
//  Created by Juan Bonforti on 11/01/2021.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController {
    
    // MARK: - Vars
    private var weatherListViewModel = WeatherListViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - Extensions
extension WeatherListTableViewController {
    
    func setupUI() {
        
        // Register Cell
        tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
        
        // Change title size of my Navbar
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addCityViewController" {
            prepareAddCitySegue(segue: segue)
        } else if segue.identifier == "settingsTableViewController" {
            prepareSettingsSegue(segue: segue)
        }
    }
    
    private func prepareAddCitySegue(segue: UIStoryboardSegue) {
        
        guard let nav = segue.destination as? UINavigationController else { fatalError("Nav not found") }
        
        guard let addCityVC = nav.viewControllers.first as? AddCityViewController else { fatalError("Add city VC, nor found") }
        
        addCityVC.delegate = self
    }
    
    private func prepareSettingsSegue(segue: UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else { fatalError("Nav not found") }
        
        guard let settingsVC = nav.viewControllers.first as? SettingsTableViewController else { fatalError("Settings VC, nor found") }
        
        settingsVC.delegate = self
    }
    
}

// TableViewDelegate, TableViewDataSource
extension WeatherListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let weatherVM = weatherListViewModel.modelAt(indexPath.row)
        
        cell.setupCell(weatherVM)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// AddCityDelegate
extension WeatherListTableViewController: AddCityDelegate {
    func addWeatherDidSave(viewModel: WeatherCityViewModel) {
        
        weatherListViewModel.addWeatherViewModel(viewModel)
        tableView.reloadData()
        
    }
}

// SettingsTableViewControllerDelegate
extension WeatherListTableViewController: SettingsTableViewControllerDelegate {
    func settingsDone(viewModel: SettingsViewModel) {
        
        weatherListViewModel.updateUnit(to: viewModel.selectedUnit)
        tableView.reloadData()
        
    }
    
}

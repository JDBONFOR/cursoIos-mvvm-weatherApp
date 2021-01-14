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
    private var dataSource: GenericTableViewDataSource<WeatherCell, WeatherCityViewModel>!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = GenericTableViewDataSource(cellIdentifier: "WeatherCell", items: weatherListViewModel.weatherCityViewModel) { cell, vm in
            cell.titleLabel.text = vm.name.value
            cell.temperatureLabel.text = vm.currentTemperature.temperature.value.formatAsDegree
        }
        tableView.dataSource = dataSource
        
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
        } else if segue.identifier == "CityDetailViewController" {
            prepareCityDetailSegue(segue: segue)
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
    
    private func prepareCityDetailSegue(segue: UIStoryboardSegue) {
        
        guard let cityDetailsVC = segue.destination as? CityDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let cityDetailsVM = weatherListViewModel.modelAt(indexPath.row)
        cityDetailsVC.viewModel = cityDetailsVM
    }
    
}

// TableViewDelegate, TableViewDataSource
extension WeatherListTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CityDetailViewController", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// AddCityDelegate
extension WeatherListTableViewController: AddCityDelegate {
    func addWeatherDidSave(viewModel: WeatherCityViewModel) {
        
        weatherListViewModel.addWeatherViewModel(viewModel)
        dataSource.updateItems(self.weatherListViewModel.weatherCityViewModel)
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

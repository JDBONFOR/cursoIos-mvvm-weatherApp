//
//  SettingsTableViewController.swift
//  WeatherApp
//
//  Created by Juan Bonforti on 12/01/2021.
//

import UIKit

protocol SettingsTableViewControllerDelegate {
    func settingsDone(viewModel: SettingsViewModel)
}

class SettingsTableViewController: UITableViewController {

    private var viewModel = SettingsViewModel()
    var delegate: SettingsTableViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change title size of my Navbar
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - IBActions
    @IBAction func doneButtonAction(_ sender: Any) {
        
        delegate?.settingsDone(viewModel: viewModel)
        
        self.dismiss(animated: true, completion: nil)
    }
    

}

// MARK: - Extensions
// TableViewDataSource, TableViewDelegate
extension SettingsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        let settingItem = viewModel.units[indexPath.row]
        
        cell.textLabel?.text = settingItem.displayName
        
        // Checkmark from Userdefaults
        if settingItem == viewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // uncheck all cells
        tableView.visibleCells.forEach{ cell in cell.accessoryType = .none }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            
            let unit = Unit.allCases[indexPath.row]
            viewModel.selectedUnit = unit
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
}

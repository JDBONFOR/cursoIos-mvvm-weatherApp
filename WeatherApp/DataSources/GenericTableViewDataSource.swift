//
//  GenericTableViewDataSource.swift
//  WeatherApp
//
//  Created by Juan Bonforti on 14/01/2021.
//

import Foundation
import UIKit

class GenericTableViewDataSource<CellType,ViewModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
    
    let cellIdentifier: String
    var items: [ViewModel]
    let configureCell: (CellType, ViewModel) -> ()
    
    init(cellIdentifier: String, items: [ViewModel], configureCell: @escaping(CellType,ViewModel) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CellType else { fatalError("CellIdentifier \(cellIdentifier) not found") }
        
        let viewModel = items[indexPath.row]
        configureCell(cell, viewModel)
        return cell
    }
}

// MARK: - Extensions
extension GenericTableViewDataSource {
    func updateItems(_ items: [ViewModel]) {
        self.items = items
    }
}

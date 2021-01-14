//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Juan Bonforti on 11/01/2021.
//

import UIKit

class WeatherCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Extension
extension WeatherCell {
    
    func setupCell(_ cell: WeatherCityViewModel) {
        self.titleLabel.text = cell.name.value
        self.temperatureLabel.text = String(cell.currentTemperature.temperature.value.formatAsDegree)
    }

}

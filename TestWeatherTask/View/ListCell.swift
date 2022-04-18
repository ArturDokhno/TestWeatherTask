//
//  ListCell.swift
//  TestWeatherTask
//
//  Created by Артур Дохно on 17.04.2022.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet var nameCityLabel: UILabel!
    @IBOutlet var conditionCityLabel: UILabel!
    @IBOutlet var tempeCityLabel: UILabel!
    
    func configure(weather: Weather) {
        self.nameCityLabel.text = weather.name
        self.conditionCityLabel.text = weather.conditionString
        self.tempeCityLabel.text = weather.temperatureString
    }
}

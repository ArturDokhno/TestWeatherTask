//
//  DetailViewController.swift
//  TestWeatherTask
//
//  Created by Артур Дохно on 17.04.2022.
//

import UIKit
import SwiftSVG

class DetailViewController: UIViewController {

    @IBOutlet var nameCityLabel: UILabel!
    @IBOutlet var viewCity: UIImageView!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var tempCity: UILabel!
    @IBOutlet var presureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    
    var weatherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshlabels()
    }
    
    func refreshlabels() {
        nameCityLabel.text = weatherModel?.name
        
        let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weatherModel!.conditionCode).svg")
        let weatherImage = UIView(svgURL: url!) { image in
            image.resizeToFit(self.viewCity.bounds)
        }
        self.viewCity.addSubview(weatherImage)
        
        conditionLabel.text = weatherModel?.conditionString
        tempCity.text = weatherModel?.temperatureString
        presureLabel.text = "\((weatherModel?.pressureMm)!)"
        windSpeedLabel.text = "\((weatherModel?.windSpeed)!)"
        minTempLabel.text = "\((weatherModel?.tempMin)!)"
        maxTempLabel.text = "\((weatherModel?.tempMax)!)"
    }
}

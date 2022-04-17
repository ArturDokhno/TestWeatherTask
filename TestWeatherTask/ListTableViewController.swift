//
//  ListTableViewController.swift
//  TestWeatherTask
//
//  Created by Артур Дохно on 17.04.2022.
//

import UIKit

class ListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         
        fetchWeather()
    }
    
    func fetchWeather() {
        
        let urlString = URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=61.242249&lon=73.453835")
        
        guard let url = urlString else { return }

        var request = URLRequest(url: url, timeoutInterval: .infinity)
        
        request.addValue("e34015c8-3e75-4172-835d-248443d7f554", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        
        
        return cell
    }

}

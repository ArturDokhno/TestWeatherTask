//
//  NetworkWeatherManager.swift
//  TestWeatherTask
//
//  Created by Артур Дохно on 17.04.2022.
//

import Foundation

struct NetworkWeatherManager {
    func fetchWeather() {
        
        let urlString = URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=61.242249&lon=73.453835")
        
        guard let url = urlString else { return }

        var request = URLRequest(url: url, timeoutInterval: .infinity)
        
        request.addValue(apiKey, forHTTPHeaderField: "X-Yandex-API-Key")
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
}

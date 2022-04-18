//
//  ListTableViewController.swift
//  TestWeatherTask
//
//  Created by Артур Дохно on 17.04.2022.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    let emptyCity = Weather()
    
    var citiesArray = [Weather]()
    var filterCitiesArray = [Weather]()
    
    var nameCitiesArray = ["Москва", "Петербург", "Пенза", "Сургут", "Уфа", "Челябинск", "Омск", "Екатеренбург", "Томск", "Сочи"]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        
        addCities()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @IBAction func pressPlusButton(_ sender: Any) {
        alertPlusCity(name: "Город", placeholder: "Введите название города") { city in
            self.nameCitiesArray.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCities()
        }
    }
    
    func addCities() {
        getCityWeather(citiesArray: self.nameCitiesArray) { (index, weather) in
            
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCitiesArray[index]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterCitiesArray.count
        }
        return citiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        
        var weather =  Weather()
        
        if isFiltering {
            weather = filterCitiesArray[indexPath.row]
        } else {
            weather = citiesArray[indexPath.row]
        }
        
        cell.configure(weather: weather)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            
            let editingRow = self.nameCitiesArray[indexPath.row]
            
            if let index = self.nameCitiesArray.firstIndex(of: editingRow) {
                
                if self.isFiltering {
                    self.filterCitiesArray.remove(at: index)
                } else {
                    self.citiesArray.remove(at: index)
                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            if isFiltering {
                let filter = filterCitiesArray[indexPath.row]
                let destinationVC = segue.destination as! DetailViewController
                destinationVC.weatherModel = filter
            } else {
                let cityWeather = citiesArray[indexPath.row]
                let destinationVC = segue.destination as! DetailViewController
                destinationVC.weatherModel = cityWeather
            }
        }
    }
}

extension ListTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filterCitiesArray = citiesArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
}

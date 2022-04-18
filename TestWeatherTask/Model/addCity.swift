//
//  addCity.swift
//  TestWeatherTask
//
//  Created by Артур Дохно on 18.04.2022.
//

import UIKit

extension UIViewController {
    
    func alertPlusCity(name: String, placeholder: String, completionHandler: @escaping (String) -> ()) {
        
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Хорошо", style: .default) { action in
            let textFieldText = alertController.textFields?.first
            guard let text = textFieldText?.text else { return }
            completionHandler(text)
        }
        
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

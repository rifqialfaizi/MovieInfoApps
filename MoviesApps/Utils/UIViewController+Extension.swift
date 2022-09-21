//
//  UIViewController+Extension.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showNoInternetConnectionAlert() {
        showAlert(title: "No Internet", message: "Please check your internet connection")
    }
    
}

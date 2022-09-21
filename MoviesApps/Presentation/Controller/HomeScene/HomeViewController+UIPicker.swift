//
//  HomeViewController+UIPicker.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import Foundation
import UIKit

extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MovieCategory.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return MovieCategory.allCases[row].title
    }
    
}

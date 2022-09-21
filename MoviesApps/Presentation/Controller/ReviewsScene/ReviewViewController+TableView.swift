//
//  ReviewViewController+TableView.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 20/09/22.
//

import Foundation
import UIKit

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviews.value?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier, for: indexPath) as? ReviewTableViewCell {
            guard let review = viewModel.reviews.value?[indexPath.row] else { return UITableViewCell() }
            cell.updateView(review: review)
            return cell
        }
        return UITableViewCell()
    }
}

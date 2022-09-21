//
//  VideoViewController+TableView.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 20/09/22.
//

import Foundation
import UIKit

extension VideoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.videos.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.reuseIdentifier, for: indexPath) as? VideoTableViewCell {
            guard let video = viewModel.videos.value?[indexPath.row]
            else { return UITableViewCell() }
            cell.updateView(video: video)
            return cell
        }
        return UITableViewCell()
    }
    
}

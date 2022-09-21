//
//  DetailViewController+TableView.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import UIKit

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            
            guard let movie = viewModel.movie else { return UITableViewCell() }
            cell.delegate = self
            cell.updateView(movie: movie)
            return cell
            
        default: ()
        
        }
        return UITableViewCell()
    }
    
}

extension DetailViewController: DetailTableViewCellDelegate {
    
    func navigateToMovieRatingScene() {
        performSegue(withIdentifier: "reviewViewControllerID", sender: self)
    }
    
    func navigateToMovieVideoScene() {
        performSegue(withIdentifier: "videoViewControllerID", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ReviewViewController {
            let viewModel = ReviewViewModel(movieId: viewModel.movie?.id ?? -99)
            vc.viewModel = viewModel
        }
        
        if let vc = segue.destination as? VideoViewController {
            let viewModel = VideoViewModel(movieId: viewModel.movie?.id ?? -99)
            vc.viewModel = viewModel
        }
    }
    
}


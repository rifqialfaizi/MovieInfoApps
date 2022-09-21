//
//  ReviewViewController.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 20/09/22.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    var viewModel: ReviewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.shared.reachability.whenUnreachable = { [weak self] _ in
            self?.showNoInternetConnectionAlert()
        }
    }
    
    private func setupTableView() {
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        reviewTableView.register(
            UINib(
                nibName: "ReviewTableViewCell",
                bundle: nil
            ), forCellReuseIdentifier: ReviewTableViewCell.reuseIdentifier)
        
    }
    
    private func bindViewModel() {
        viewModel.reviews.bind { [weak self] reviews in
            if let reviews = reviews, reviews.isEmpty {
                self?.showAlert(title: "No Review", message: "This movie has no review")
            }
            
            DispatchQueue.main.async {
                self?.reviewTableView.reloadData()
            }
        }
    }
    
}

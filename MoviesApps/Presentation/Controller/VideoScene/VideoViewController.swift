//
//  VideoViewController.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 20/09/22.
//

import UIKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var videoTableView: UITableView!
    
    var viewModel: VideoViewModel!
    
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
        videoTableView.dataSource = self
        videoTableView.delegate = self
        videoTableView.register(
            UINib(
                nibName: "VideoTableViewCell",
                bundle: nil
            ), forCellReuseIdentifier: VideoTableViewCell.reuseIdentifier)
    }
    
    private func bindViewModel() {
        viewModel.videos.bind { [weak self] videos in
            if let videos = videos, videos.isEmpty {
                self?.showAlert(title: "No Videos", message: "This movie has no videos")
            }
            
            DispatchQueue.main.async {
                self?.videoTableView.reloadData()
            }
        }
    }
    
}

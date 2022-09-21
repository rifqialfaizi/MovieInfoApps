//
//  HomeCollectionViewCell.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 24/08/22.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    static var reuseIdentifier = "movieCell"
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.movieImage.layer.cornerRadius = 10
    }
    
    func updateView(movie: Movie?) {
        guard let movie = movie else { return }
        let imageApi = "https://image.tmdb.org/t/p/original" + movie.posterPath
        self.movieTitle.text = movie.title
        self.movieImage.networkImage(from: imageApi)
        self.movieImage.contentMode = .scaleAspectFill
    }

}

//
//  MovieCollectionViewCell.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier = "movieCell"
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var movieRate: UILabel!
    
    override func prepareForReuse() {
        self.movieImage.image = UIImage()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.movieImage.layer.cornerRadius = 10
        self.movieView.layer.cornerRadius = 10
    }
    
    func updateView(movie: Movie?) {
        guard let movie = movie else { return }
        let imageUrl = "https://image.tmdb.org/t/p/original" + (movie.posterPath ?? "")
        self.movieTitle.text = movie.title
        self.movieDate.text = movie.releaseDate
        self.movieRate.text = String(movie.voteAverage)
        self.movieImage.setImage(from: imageUrl)
    }
}

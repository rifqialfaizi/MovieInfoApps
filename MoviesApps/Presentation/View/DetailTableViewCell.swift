//
//  DetailTableViewCell.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import UIKit

protocol DetailTableViewCellDelegate {
    func navigateToMovieRatingScene()
    func navigateToMovieVideoScene()
}


class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieView: UIView!
    
    @IBOutlet weak var movieReviews: UIButton!
    @IBOutlet weak var movieVideos: UIButton!
    
    var delegate: DetailTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.movieView.layer.cornerRadius = 20
    }
    
    func updateView(movie: Movie) {
        movieTitle.text = movie.title.capitalized
        movieDate.text = movie.releaseDate
        movieOverview.text = movie.overview
        movieRating.text = "\(movie.voteAverage)"
        
        let imageUrl = "https://image.tmdb.org/t/p/original" + (movie.posterPath ?? "")
        movieImage.setImage(from: imageUrl)
    }
    
    @IBAction func movieReviewsBtn(_ sender: Any) {
        delegate.navigateToMovieRatingScene()
    }
    
    @IBAction func movieVideosBtn(_ sender: Any) {
        delegate.navigateToMovieVideoScene()
    }
    
    
    
}

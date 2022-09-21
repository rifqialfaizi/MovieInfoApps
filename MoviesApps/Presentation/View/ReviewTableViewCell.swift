//
//  ReviewTableViewCell.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 20/09/22.
//

import UIKit


class ReviewTableViewCell: UITableViewCell {

    static var reuseIdentifier = "reviewCell"
    
    @IBOutlet weak var movieAuthor: UILabel!
    @IBOutlet weak var movieReview: UITextView!
    @IBOutlet weak var reviewView: UIView!
    
    func updateView(review: Review?) {
        guard let review = review else { return }
        self.reviewView.layer.cornerRadius = 10
        self.movieAuthor.text = review.author
        self.movieReview.text = review.content
    }
    

    
}

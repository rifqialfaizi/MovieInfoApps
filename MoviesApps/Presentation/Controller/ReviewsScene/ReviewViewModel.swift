//
//  ReviewViewModel.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 20/09/22.
//

import Foundation

class ReviewViewModel {
    
    var reviews = Bindable<[Review]>()
    var movieId:Int

    init(movieId: Int) {
        self.movieId = movieId
        loadData()
    }
    
    private func loadData() {
        NetworkService.shared.fetchReviews(movieId: movieId) { result in
            switch result {
            case.success(let reviews):
                self.reviews.value = reviews
            case.failure(let error):
                self.reviews.value = []
                print(error)
            }
        }
    }
    
}

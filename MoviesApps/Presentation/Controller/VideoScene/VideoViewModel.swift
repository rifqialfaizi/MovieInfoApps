//
//  VideoViewModel.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 20/09/22.
//

import Foundation

class VideoViewModel {
    
    var videos = Bindable<[Video]>()
    var movieId:Int
    
    init(movieId: Int) {
        self.movieId = movieId
        loadData()
    }
    
    private func loadData(){
        NetworkService.shared.fetchVideos(movieId: movieId) {
            result in
            switch result {
            case.success(let videos):
                self.videos.value = videos
            case.failure(let error):
                self.videos.value = []
                print(error)
            }
        }
    }
}

//
//  HomeViewModel.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import Foundation
import CoreData
import UIKit
import Alamofire

class HomeViewModel {
    
    private var isLoading = false
    private var currentPage = 0
    private var totalPage = 0
    private var allMovies = [Movie]()
    var movies = Bindable<[Movie]>()
    var category = MovieCategory.popular
    
    
    // Retrieve data from Core Data
    func loadDataFromPersistent() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = MovieEntity.fetchRequest()
        
        do {
            let movies = try context.fetch(request)
            guard movies.count > 0 else { return }
            self.movies.value = movies.compactMap {
                Movie(backdropPath: nil, posterPath: $0.posterPath, releaseDate: $0.releaseDate!, title: $0.title!, voteAverage: $0.voteAverage)
            }
            print(movies)
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func loadData(shouldResetData: Bool) {
        if shouldResetData {
            if allMovies.isEmpty {
                loadDataFromPersistent()
            } else {
                currentPage = 0
                allMovies = []
                movies.value = []
            }
        }
        if isLoading || currentPage > totalPage { return }
        currentPage += 1
        fetchMovie(page: currentPage)
    }
    
    func getMovie(at index: Int) -> Movie? {
            guard let movie = movies.value?[index] else { return nil }
            return movie
        }

        private func fetchMovie(page:Int) {
            print("✅ Fetching \(category) movie at page \(page)")
            isLoading = true
            NetworkService.shared.fetchMovies(page: page, category: category) { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let movieResult):
                    
                    self.totalPage = movieResult.totalPages
                    self.allMovies += movieResult.results
                    self.movies.value = self.allMovies
                    
                    // Save movies to Core Data
                    CoreData.sharedInstance.saveMovies(movies: self.allMovies)
           
                case .failure(let error):
                    print(error)
                }
        }
    }
    
}

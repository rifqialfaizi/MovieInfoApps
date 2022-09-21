//
//  CoreData.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import UIKit
import CoreData

class CoreData {
    
    static let sharedInstance = CoreData()
    private init () {}
    
    private let continer: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    
    func saveMovies(movies:[Movie]) {
        
        self.continer?.performBackgroundTask { [weak self] (context) in
            self?.deleteObjectsFromCoreData(context: context)
            self?.saveDataToCoreData(movies: movies, context: context)
        }
    }
    
    private func deleteObjectsFromCoreData(context: NSManagedObjectContext) {
        do {
            let objects = try context.fetch(fetchRequest)
            _ = objects.map({context.delete($0)})
            try context.save()
        } catch {
            print("Deleting Error: \(error)")
        }
    }
    
    private func saveDataToCoreData(movies:[Movie], context: NSManagedObjectContext) {
        
        context.perform {
            for movie in movies {
                let movieEntity = MovieEntity(context: context)
                movieEntity.title = movie.title
                movieEntity.releaseDate = movie.releaseDate
                movieEntity.voteAverage = movie.voteAverage
                movieEntity.posterPath = movie.posterPath
                movieEntity.overview = movie.overview
            }
            
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}

//
//  MovieEntity+CoreDataProperties.swift
//  
//
//  Created by Rifqi Alfaizi on 20/09/22.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }


}

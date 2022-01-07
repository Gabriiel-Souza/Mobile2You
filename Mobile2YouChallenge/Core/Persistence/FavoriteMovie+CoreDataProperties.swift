//
//  FavoriteMovie+CoreDataProperties.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 06/01/22.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var id: Int32

}

extension FavoriteMovie : Identifiable {

}

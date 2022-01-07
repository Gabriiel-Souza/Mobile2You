//
//  PersistenceController.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 06/01/22.
//

import UIKit
import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    let context: NSManagedObjectContext?
    
    private var persistentContainer: NSPersistentContainer? = {
        let container = NSPersistentContainer(name: "Mobile2YouChallenge")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Can't get persistentContainer, error: \(error.localizedDescription)")
                return
            }
        })
        return container
    }()

    private init() {
        context = persistentContainer?.viewContext
    }
    
    func fetchFavoriteMovie(id: Int) -> FavoriteMovie?{
        do {
            let fetchRequest: NSFetchRequest<FavoriteMovie>
            fetchRequest = FavoriteMovie.fetchRequest()

            fetchRequest.predicate = NSPredicate(
                format: "id LIKE %@", id
            )

            // Perform the fetch request to get the objects
            // matching the predicate
            let movie = try context?.fetch(fetchRequest).first
            return movie
        } catch {
            print("Error in Player Data Fetch Request: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveContext() {
        if let context = persistentContainer?.viewContext {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print("Can't save context, error: \(error.localizedDescription)")
                }
            }
        }
    }
    
}

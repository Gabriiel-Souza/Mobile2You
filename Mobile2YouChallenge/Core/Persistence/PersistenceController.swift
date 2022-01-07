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
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Can't get persistentContainer, error: \(error.localizedDescription)")
                return
            }
        }
        return container
    }()
    
    private init() {
        context = persistentContainer?.viewContext
    }
    
    func fetchFavoriteMovie(id: Int) -> FavoriteMovie? {
        do {
            let fetchRequest: NSFetchRequest<FavoriteMovie>
            fetchRequest = FavoriteMovie.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(
                format: "id LIKE %@", "\(id)"
            )
            
            // Perform the fetch request to get the objects
            // matching the predicate
            let movie = try context?.fetch(fetchRequest).first
            return movie
        } catch {
            print("Error in Favorite Movie Fetch Request: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchFavoriteMovies() -> [FavoriteMovie]? {
        do {
            let movies = try context?.fetch(FavoriteMovie.fetchRequest())
            return movies
        } catch {
            print("Error in Favorite Movie Fetch Request: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteMovie(_ movie: FavoriteMovie) {
        context?.delete(movie)
        save()
    }
    
    func addMovie(id: Int) {
        guard let context = context else { return }
        let newMovie = FavoriteMovie(context: context)
        newMovie.id = Int32(id)
        save()
    }
    
    private func save() {
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

//
//  LocalStorage.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/11/22.
//

import CoreData
import RxSwift

final class LocalStorage {
    private let context: NSManagedObjectContext
    
    init(with context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getMovies() -> Observable<[Movie]> {
        return .create { (observer) in
            let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
            do {
                let movies = try self.context.fetch(fetchRequest)
                observer.onNext(movies.map({ $0.mapToMovie() }))

              } catch let error {
                observer.onError(error)
              }
            return Disposables.create()
        }
    }
    
    func saveMovie(_ movie: Movie) -> Observable<Bool> {
        
        return .create { (observer) in
            
            let entity = MovieEntity(context: self.context)
            entity.fill(from: movie)
            
            do {
                try self.context.save()
                observer.onNext(true)

              } catch let error {
                observer.onError(error)
              }
            return Disposables.create()
        }
        
    }
    
    func deleteMovie(_ movie: Movie) -> Observable<Bool> {
        
        return .create { (observer) in
            let fetchRequest = NSFetchRequest<MovieEntity>()
            fetchRequest.predicate = .init(format: "trackId=\(movie.trackId)")
            
            do {
                let movies = try self.context.fetch(fetchRequest)
                movies.forEach({ movie in
                    self.context.delete(movie)
                })
                
                try self.context.save()
                observer.onNext(true)

              } catch let error {
                observer.onError(error)
              }
            return Disposables.create()
        }
        
    }
}

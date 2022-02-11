//
//  DeleteFavoriteMovieUseCase.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/11/22.
//

import Foundation
import RxSwift

class DeleteFavoriteMovieUseCase {
    
    // MARK: Properties
    private let movieRepository: MovieRepository
    
    // MARK: Constructor
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    // MARK: Functions
    func execute(_ movie: Movie) -> Observable<Bool> {
        return self.movieRepository.deleteFavoriteMovie(movie: movie)
    }
}

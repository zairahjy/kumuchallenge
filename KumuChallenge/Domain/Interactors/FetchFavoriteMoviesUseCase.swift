//
//  FetchFavoriteMoviesUseCase.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/11/22.
//

import Foundation
import RxSwift

class FetchFavoriteMoviesUseCase {
    
    // MARK: Properties
    private let movieRepository: MovieRepository
    
    // MARK: Constructor
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    // MARK: Functions
    func execute(_ searchString: String?) -> Observable<[Movie]> {
        return self.movieRepository.fetchMovies(string: searchString)
    }
}


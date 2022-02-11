//
//  MovieRepository.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import Foundation
import RxSwift

protocol MovieRepository {
    func fetchMovies(string: String?) -> Observable<[Movie]>
    func saveFavoriteMovie(movie: Movie) -> Observable<Bool>
    func deleteFavoriteMovie(movie: Movie) -> Observable<Bool>
}

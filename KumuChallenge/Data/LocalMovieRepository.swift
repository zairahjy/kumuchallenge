//
//  LocalMovieRepository.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/11/22.
//


import RxSwift

class MovieLocalStorage: MovieRepository {
    
    private let localStorage: LocalStorage
    
    init(localStorage: LocalStorage) {
        self.localStorage = localStorage
    }
    
    func fetchMovies(string: String?) -> Observable<[Movie]> {
        return localStorage.getMovies()
    }
    
    func saveFavoriteMovie(movie: Movie) -> Observable<Bool> {
        return localStorage.saveMovie(movie)
    }
    
    func deleteFavoriteMovie(movie: Movie) -> Observable<Bool> {
        return localStorage.deleteMovie(movie)
    }
}

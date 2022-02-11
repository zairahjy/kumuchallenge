//
//  MovieWebServices.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import RxSwift

class MovieWebServices: MovieRepository {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchMovies(string: String?) -> Observable<[Movie]> {
        
        let stringURL = "https://itunes.apple.com/search"
        var param = MovieSearchParam()
        if let term = string, !term.isEmpty {
            param = MovieSearchParam(term: term)
        }
        let resource = Resource(urlString: stringURL, param: param)
        
        return apiClient.load(resource).map({ (data) -> [Movie] in
            do {
                let rawResponse = try JSONDecoder().decode(FetchMovieResponse.self, from: data)
                let movies = rawResponse.results
                return movies
            }
            catch {
                throw APIClientError.internalError(msg: "Error decoding response data: \(error)")
            }
        })
        
    }
    
    func saveFavoriteMovie(movie: Movie) -> Observable<Bool> {
        fatalError()
    }
    
    func deleteFavoriteMovie(movie: Movie) -> Observable<Bool> {
        fatalError()
    }
}

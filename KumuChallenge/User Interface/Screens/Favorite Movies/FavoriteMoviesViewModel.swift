//
//  FavoriteMoviesViewModel.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import RxSwift

class FavoriteMoviesViewModel {
    //MARK: Properties
    let loadingSubject: PublishSubject<Bool> = PublishSubject()
    let moviesSubject: PublishSubject<[Movie]> = PublishSubject()
    let errorSubject: PublishSubject<String?> = PublishSubject()
    let termSubject: PublishSubject<String> = PublishSubject()
    var termObserver: AnyObserver<String> {
        return termSubject.asObserver()
    }
    
    private var movies: [Movie] = []
    private let fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase
    private let saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase
    private let deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase
    let disposeBag: DisposeBag = DisposeBag()
    
    //MARK: Constructors
    init(fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase,
         saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase,
         deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase) {
        self.fetchFavoriteMoviesUseCase = fetchFavoriteMoviesUseCase
        self.saveFavoriteMovieUseCase = saveFavoriteMovieUseCase
        self.deleteFavoriteMovieUseCase = deleteFavoriteMovieUseCase
        
        termSubject
            .asObservable()
            .distinctUntilChanged()
            .debounce(.milliseconds(5), scheduler: MainScheduler.instance)
            .subscribe { (term) in
                if let t = term.element, !t.isEmpty {
                    let filteredMovies = self.movies.filter { (movie) in
                        return movie.trackName.contains(t)
                    }
                    self.moviesSubject.onNext(filteredMovies)
                } else {
                    self.fetchMovies()
                }
            }
            .disposed(by: disposeBag)

    }
    
    //MARK: Functions
    func fetchMovies(searchString: String? = nil) {
        self.loadingSubject.onNext(true)
        self.fetchFavoriteMoviesUseCase.execute(searchString).subscribe { (movies) in
            self.movies = movies
            self.loadingSubject.onNext(false)
            self.moviesSubject.onNext(movies)
        } onError: { (error) in
            self.loadingSubject.onNext(false)
            self.errorSubject.onNext(error.localizedDescription)
        }.disposed(by: disposeBag)

    }
    
}


//
//  MovieListViewModel.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import RxSwift

class MovieListViewModel {
    //MARK: Properties
    let loadingSubject: PublishSubject<Bool> = PublishSubject()
    let moviesSubject: PublishSubject<[Movie]> = PublishSubject()
    let errorSubject: PublishSubject<String?> = PublishSubject()
    let termSubject: PublishSubject<String> = PublishSubject()
    var termObserver: AnyObserver<String> {
        return termSubject.asObserver()
    }
    
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private let fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase
    private let saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase
    private let deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase
    let disposeBag: DisposeBag = DisposeBag()
    
    //MARK: Constructors
    init(fetchMoviesUseCase: FetchMoviesUseCase,
         fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase,
         saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase,
         deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
        self.fetchFavoriteMoviesUseCase = fetchFavoriteMoviesUseCase
        self.saveFavoriteMovieUseCase = saveFavoriteMovieUseCase
        self.deleteFavoriteMovieUseCase = deleteFavoriteMovieUseCase
        
        termSubject
            .asObservable()
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .debounce(.milliseconds(5), scheduler: MainScheduler.instance)
            .subscribe { (term) in
                self.fetchMovies(searchString: term)
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: Functions
    func fetchMovies(searchString: String? = "") {
        self.loadingSubject.onNext(true)
        self.fetchMoviesUseCase.execute(searchString).subscribe { (movies) in
            print("success fetch")
            self.loadingSubject.onNext(false)
            self.moviesSubject.onNext(movies)
        } onError: { (error) in
            print("error fetch: ", error)
            self.loadingSubject.onNext(false)
            self.errorSubject.onNext(error.localizedDescription)
        }.disposed(by: disposeBag)

    }
    
    func saveFavoriteMovie(_ movie: Movie) {
        self.loadingSubject.onNext(true)
        self.saveFavoriteMovieUseCase.execute(movie).subscribe { (saved) in
            self.loadingSubject.onNext(false)
            print("fav success")
            //TODO update list
        } onError: { (error) in
            print("fav failed", error)
            self.loadingSubject.onNext(false)
        }
        .disposed(by: disposeBag)
    }
    
    func deleteFavoriteMovie(_ movie: Movie) {
        self.loadingSubject.onNext(true)
        self.deleteFavoriteMovieUseCase.execute(movie).subscribe { (saved) in
            self.loadingSubject.onNext(false)
            //TODO update list
        } onError: { (error) in
            self.loadingSubject.onNext(false)
        }
        .disposed(by: disposeBag)
    }
    
}

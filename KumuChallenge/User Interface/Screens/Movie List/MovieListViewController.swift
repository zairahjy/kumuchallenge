//
//  MovieListViewController.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: BaseViewController {
    
    // MARK: Properties
    private lazy var rootView: MovieListVCRootView = {
        let view = MovieListVCRootView()
        return view
    }()

    private var viewModel: MovieListViewModel
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Life Cycle
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        
        viewModel.fetchMovies()
    }
    
    // MARK: Functions
    func setupBindings() {
        setupSearchBinding()
        setupLoaderBinding()
        setupErrorBinding()
        setupMoviesBinding()
            
    }
    
    func setupSearchBinding() {
        rootView
            .searchBar
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.termObserver)
            .disposed(by: disposeBag)
    }
    
    func setupLoaderBinding() {
        viewModel
            .loadingSubject
            .observe(on: MainScheduler.instance)
            .bind(to: rootView.loaderView.rx.loading)
            .disposed(by: disposeBag)
    }
    
    func setupErrorBinding() {
        viewModel
            .errorSubject
            .observe(on: MainScheduler.instance)
            .bind(to: rootView.errorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .errorSubject
            .observe(on: MainScheduler.instance)
            .bind(onNext: { (error) in
                self.rootView.errorLabel.isHidden = error == nil
            })
            .disposed(by: disposeBag)
    }
    
    func setupMoviesBinding() {
        
        rootView
            .refreshControl
            .rx
            .controlEvent(.valueChanged)
            .bind(onNext: ({ self.viewModel.fetchMovies() }))
            .disposed(by: disposeBag)
        
        viewModel
            .moviesSubject
            .observe(on: MainScheduler.instance)
            .bind(to: rootView.collectionView.rx.items(cellIdentifier: MovieCollectionViewCell.getName(), cellType: MovieCollectionViewCell.self)) { index, movie, cell in
                cell.artworkImageView.downloaded(from: movie.artWorkUrl)
                cell.titleLabel.text = movie.trackName
                cell.genreLabel.text = movie.genre
                if let formattedPrice = movie.price?.formatted() {
                    cell.priceLabel.text = "\(movie.currency) \(formattedPrice)"
                }
                
                cell.favTap
                    .subscribe(onNext: {
                        self.viewModel.saveFavoriteMovie(movie)
                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        viewModel
            .moviesSubject
            .observe(on: MainScheduler.instance)
            .bind { (_) in
                self.rootView.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
        
        rootView
            .collectionView
            .rx
            .modelSelected(Movie.self)
            .subscribe { (movie) in
                self.coordinator?.present(MainDestination.movieDetails(movie: movie))
            }
            .disposed(by: disposeBag)

    }
   
}

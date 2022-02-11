//
//  AppFactory.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import Swinject
import SwinjectAutoregistration

/// This is where the classes constructed.
class AppAssembler {
    
    // Using DI to easily construct objects.
    private var container: Container
    private(set) var resolver: Resolver
    
    init() {
        container = Container()
        resolver = container.synchronize()
        registerUserInterface()
        registerDomain()
        registerData()
    }
    
    /// Setup for UI Layer. Contains View and ViewModel
    func registerUserInterface() {
        container.autoregister(MovieListViewModel.self, initializer: MovieListViewModel.init).inObjectScope(.container)
        container.autoregister(FavoriteMoviesViewModel.self, initializer: FavoriteMoviesViewModel.init).inObjectScope(.container)
        
        container.autoregister(MovieListViewController.self, initializer: MovieListViewController.init).inObjectScope(.container)
        container.autoregister(FavoriteMoviesViewController.self, initializer: FavoriteMoviesViewController.init).inObjectScope(.container)
    }
    
    /// Setup for Domain. Contains Use Cases and Repository
    func registerDomain() {
        container.autoregister(
            MovieRepository.self,
            name: String(describing: MovieWebServices.self),
            initializer: MovieWebServices.init
        ).inObjectScope(.container)
        
        container.autoregister(
            MovieRepository.self,
            name: String(describing: MovieLocalStorage.self),
            initializer: MovieLocalStorage.init
        ).inObjectScope(.container)
        
        container.register(FetchMoviesUseCase.self) { (resolver) in
            let repo = resolver.resolve(MovieRepository.self, name: String(describing: MovieWebServices.self))!
            return FetchMoviesUseCase(movieRepository: repo)
        }.inObjectScope(.container)
        
        container.register(FetchFavoriteMoviesUseCase.self) { (resolver) in
            let repo = resolver.resolve(MovieRepository.self, name: String(describing: MovieLocalStorage.self))!
            return FetchFavoriteMoviesUseCase(movieRepository: repo)
        }.inObjectScope(.container)
        
        container.register(SaveFavoriteMovieUseCase.self) { (resolver) in
            let repo = resolver.resolve(MovieRepository.self, name: String(describing: MovieLocalStorage.self))!
            return SaveFavoriteMovieUseCase(movieRepository: repo)
        }.inObjectScope(.container)
        
        container.register(DeleteFavoriteMovieUseCase.self) { (resolver) in
            let repo = resolver.resolve(MovieRepository.self, name: String(describing: MovieLocalStorage.self))!
            return DeleteFavoriteMovieUseCase(movieRepository: repo)
        }.inObjectScope(.container)

    }
    
    /// Setup for Data. Contains API integration and Local Storage
    func registerData() {
        container.autoregister(APIClient.self, initializer: APIClient.init).inObjectScope(.container)
        
        container.register(LocalStorage.self) { (resolver) in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return LocalStorage(with: appDelegate.persistentContainer.viewContext)
        }
    }
}

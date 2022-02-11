//
//  MainCoordinator.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import UIKit
import Swinject

/// Define here the destination flow
enum MainDestination {
    case main([MainViewController.Tab])
    case movieDetails(movie: Movie)
}

/// Use for navigation
class MainCoordinator {
   
    var rootViewController: UIViewController
    
    private var resolver: Resolver
    
    init(resolver: Resolver, destination: MainDestination) {
        self.resolver = resolver
        let navVC = UINavigationController()
        navVC.isToolbarHidden = true
        navVC.navigationBar.isHidden = true
        self.rootViewController = navVC
        navVC.viewControllers = [self.getViewController(for: destination)]   
    }
    
    func present(_ destination: MainDestination) {
        rootViewController.present(getViewController(for: destination), animated: true)
    }
    
    private func getViewController(for destination: MainDestination) -> UIViewController {
        switch destination {
            case .main(let tabs):
                let vc = MainViewController(tabs: tabs, coordinator: self)
                return vc
            case .movieDetails(let movie):
                let vc = MovieDetailsViewController(movie: movie)
                vc.coordinator = self
                return vc
        }
    }
    
}

/// Base class for UIViewControllers
class BaseViewController: UIViewController {
    /// To easily access the coordinator for the navigation
    var coordinator: MainCoordinator?
}

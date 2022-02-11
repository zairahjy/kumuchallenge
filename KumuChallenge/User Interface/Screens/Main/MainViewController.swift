//
//  MainViewController.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/9/22.
//

import UIKit

class MainViewController: UITabBarController {
    
    //MARK: Properties
    struct Tab {
        var iconName: String
        var viewController: BaseViewController
    }
    
    private var tabs: [Tab]
    var coordinator: MainCoordinator?
    
    // MARK: Life Cycle
    init(tabs: [Tab], coordinator: MainCoordinator) {
        self.tabs = tabs
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupViews()
    }
    
    // MARK: Functions
    func setupViews() {
        self.tabs.forEach { (tab) in
            tab.viewController.coordinator = self.coordinator
            tab.viewController.tabBarItem = UITabBarItem(
                title: nil,
                image: UIImage(systemName: tab.iconName),
                selectedImage: UIImage(systemName: "\(tab.iconName).fill")
            )
        }
        self.viewControllers = self.tabs.map({ $0.viewController })
        
    }
}


//
//  LoaderView.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/11/22.
//

import UIKit


/// Custom view for loading state
class LoaderView: UIView {
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    // MARK: Constructors
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    func setupViews() {
        addSubview(loadingIndicator)
    }
    
    func setupConstraints() {
        loadingIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func startAnimation() {
        self.isHidden = false
        self.loadingIndicator.startAnimating()
    }
    
    func stopAnimation() {
        self.isHidden = true
        self.loadingIndicator.stopAnimating()
        
    }
}

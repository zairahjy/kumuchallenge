//
//  MovieListVCRootView.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import SnapKit
import RxCocoa
import RxSwift

class MovieListVCRootView: UIView {
    // MARK: SubViews
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search Movies"
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.getName())
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
    lazy var loaderView: LoaderView = {
        let view = LoaderView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        return view
    }()
    
    lazy var errorLabel: UILabel = {
        let view = UILabel()
        view.isHidden = true
        view.numberOfLines = 0
        view.backgroundColor = .white
        view.textAlignment = .center
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
        addSubview(searchBar)
        addSubview(collectionView)
        addSubview(loaderView)
        collectionView.addSubview(refreshControl)
        collectionView.addSubview(errorLabel)
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(snp_topMargin)
            make.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        loaderView.snp.makeConstraints { (make) in
            make.margins.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
    }
}

// MARK: Extension - UICollectionViewDelegateFlowLayout
extension MovieListVCRootView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 110
        return CGSize(width: width, height: height)
    }
}

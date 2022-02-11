//
//  MovieDetailsVCRootView.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/11/22.
//

import SnapKit
import AVFoundation

class MovieDetailsVCRootView: UIView {
    
    let defaultMargin = 16
    let defaultSpacing = 8
        
    // MARK: UI Properties
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    lazy var mainContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var detailsContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var previewView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var artworkImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    lazy var genreLabel: UILabel = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: view.font.pointSize, weight: .semibold)
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    // MARK: Constructors
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(mainContainerView)
        mainContainerView.addSubview(previewView)
        mainContainerView.addSubview(detailsContainerView)
        previewView.addSubview(artworkImageView)
        detailsContainerView.addSubview(titleLabel)
        detailsContainerView.addSubview(genreLabel)
        detailsContainerView.addSubview(priceLabel)
        detailsContainerView.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        mainContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(snp.edges)
        }
        
        previewView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(-22)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        detailsContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(previewView.snp.bottom).inset(defaultMargin)
            make.leading.equalTo(snp.leading).inset(defaultMargin)
            make.bottom.equalTo(snp.bottom).inset(-defaultMargin)
            make.trailing.equalTo(snp.trailing).offset(-defaultMargin)
        }
        
        artworkImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(previewView.snp.bottom).inset(-defaultMargin)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(genreLabel.snp.top).inset(-defaultSpacing)
        }
        
        genreLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(priceLabel.snp.top).inset(-defaultSpacing)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(descriptionLabel.snp.top).inset(-defaultMargin)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}

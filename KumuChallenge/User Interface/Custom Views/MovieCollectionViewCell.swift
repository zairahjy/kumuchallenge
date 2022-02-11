//
//  MovieCollectionViewCell.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/11/22.
//

import UIKit
import RxSwift


/// Custom collection view cell specific to movie details
class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: Static Functions
    static func getName() -> String {
        return "MovieCell"
    }
    
    // MARK: UI Properties
    lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    lazy var artworkImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "movie-placeholder")
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
    
    lazy var favButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "star"), for: .normal)
        return view
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: Properties
    var favTap : Observable<Void> {
        return self.favButton.rx.tap.asObservable()
    }
    
    // MARK: Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Functions
    private func setupViews() {
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(genreLabel)
        addSubview(artworkImageView)
        addSubview(containerStackView)
        addSubview(priceLabel)
        addSubview(favButton)
        addSubview(dividerView)
    }
    
    private func setupConstraints() {
        artworkImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.bottom.top.equalToSuperview().inset(8)
            make.width.equalTo(100)
        }
        containerStackView.snp.makeConstraints { (make) in
            make.leading.equalTo(artworkImageView.snp.trailing)
            make.top.equalTo(artworkImageView.snp.top)
            make.trailing.equalTo(favButton.snp.leading)
            make.bottom.lessThanOrEqualTo(priceLabel.snp.top)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(containerStackView.snp.leading)
            make.trailing.equalTo(favButton.snp.leading)
            make.bottom.equalTo(artworkImageView.snp.bottom)
        }
        
        favButton.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.trailing.bottom.leading.equalToSuperview()
        }
    }
    
}


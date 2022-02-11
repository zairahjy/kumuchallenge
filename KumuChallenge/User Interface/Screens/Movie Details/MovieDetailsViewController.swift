//
//  MovieDetailsViewController.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/11/22.
//

import UIKit
import RxSwift
import AVFoundation

class MovieDetailsViewController: BaseViewController {
    
    // MARK: Properties
    private lazy var rootView: MovieDetailsVCRootView = {
        let view = MovieDetailsVCRootView()
        return view
    }()
    private var movie: Movie
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Life Cycle
    init(movie: Movie) {
        self.movie = movie
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
        
        renderDataToViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: Functions
    func renderDataToViews() {
        rootView.artworkImageView.downloaded(from: movie.artWorkUrl)
        rootView.titleLabel.text = movie.trackName
        rootView.genreLabel.text = movie.genre
        if let formattedPrice = movie.price?.formatted() {
            rootView.priceLabel.text = "\(movie.currency) \(formattedPrice)"
        }
        rootView.descriptionLabel.text = movie.description
        
        if let videoURL = movie.previewUrl {
            let player = AVPlayer(url: videoURL)
            let playerLayer = AVPlayerLayer(player: player)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                playerLayer.frame = self.rootView.previewView.bounds
                self.rootView.previewView.layer.addSublayer(playerLayer)
                player.play()
            }
        }
    }
}

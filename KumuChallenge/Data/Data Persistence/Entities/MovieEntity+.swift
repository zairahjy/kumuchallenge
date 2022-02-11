//
//  MovieEntity+.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/11/22.
//

import Foundation

extension MovieEntity {
    func fill(from movie: Movie) {
        trackId = Int64(movie.trackId)
        trackName = movie.trackName
        artWorkUrl = movie.artWorkUrl
        genre = movie.genre
        price = movie.price as NSDecimalNumber?
        currency = movie.currency
        longDescription = movie.description
        previewUrl = movie.previewUrl
    }
    
    func mapToMovie() -> Movie {
        return Movie(
            trackId: Int(trackId),
            trackName: trackName!,
            artWorkUrl: artWorkUrl!,
            currency: currency!,
            price: price as Decimal? ?? nil,
            genre: genre!,
            description: longDescription!,
            previewUrl: previewUrl ?? nil
        )
    }
}

//
//  Movie.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import Foundation

struct Movie: Codable {
    let trackId: Int
    let trackName: String
    let artWorkUrl: URL
    let currency: String
    let price: Decimal?
    let genre: String
    let description: String
    let previewUrl: URL?
    var isFavorite: Bool = false
    
    private enum CodingKeys : String, CodingKey {
        case trackId,
             trackName,
             artWorkUrl = "artworkUrl100",
             currency,
             price = "trackPrice",
             genre = "primaryGenreName",
             description = "longDescription",
             previewUrl
    }
    
    mutating func setFavorite() {
        isFavorite.toggle()
    }
}

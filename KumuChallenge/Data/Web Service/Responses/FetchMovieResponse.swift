//
//  FetchMovieResponse.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import Foundation

struct FetchMovieResponse: Codable {
    var resultCount: Int
    var results: [Movie]
}

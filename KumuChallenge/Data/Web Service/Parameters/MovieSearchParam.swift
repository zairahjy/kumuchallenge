//
//  MovieSearchParam.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import Foundation

struct MovieSearchParam: DictionaryEncodable {
    var country: String = "AU"
    var media: String = "movie"
    var term: String = "star"
}

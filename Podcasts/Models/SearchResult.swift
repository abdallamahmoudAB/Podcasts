//
//  SearchResult.swift
//  Podcasts
//
//  Created by abdalla mahmoud on 19/04/2022.
//

import Foundation

struct SearchResult: Codable {
    var resultCount: Int?
    var results: [Results]
}

struct Results: Codable {
    var artistName: String?
    var trackName: String?
    var artworkUrl100: String?
    var trackCount: Int?
    var feedUrl: String?
}

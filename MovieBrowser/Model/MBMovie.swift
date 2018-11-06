//
//  MBMovie.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation

struct MBMovie: Codable {
    let title: String
    let year: String
    let imdbId: String
    let type: String
    let poster: URL
    // optional keys
    var plot: String?
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
        case plot = "Plot"
    }
}

struct SearchResults: Codable {
    let search: [MBMovie]
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

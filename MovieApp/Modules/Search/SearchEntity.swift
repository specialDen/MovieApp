//
//  SearchEntity.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import Foundation

struct SearchResults: Codable {
    let results: [SearchModel]
}

struct SearchModel: Codable {
    let id: Int
    let name: String
}

enum TableViewContentType {
    case topMoviesAndSeries(ContentType)
    case searchResults(ContentType)
}

enum ContentType {
    case movies, series
}


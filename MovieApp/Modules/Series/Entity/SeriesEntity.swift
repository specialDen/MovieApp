//
//  SeriesEntity.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import Foundation
//
struct SeriesData: Codable {
    
    let results: [Series]
   
}

struct Series: Codable {
    
    let id: Int?
    let vote_average: Double?
    let name: String?
    let first_air_date: String?
    let overview: String?
    let poster_path: String?
    
}

enum SeriesLists {
    
    
    case topRatedSeries(_ movies: SeriesData)
    case latestSeries(_ movies: SeriesData)
    case onAirTvs(_ movies: SeriesData)
    case popularSeries(_ movies: SeriesData)
    
    static var allCases: [SeriesLists] {
        let mockMovie = Series(id: nil, vote_average: nil, name: nil, first_air_date: nil, overview: nil, poster_path: nil)
        
        let mockSeriesData = SeriesData(results: [mockMovie])
        return [.latestSeries(mockSeriesData),
                .topRatedSeries(mockSeriesData),
                .onAirTvs(mockSeriesData),
                .popularSeries(mockSeriesData)]
    }

    var items: [Series] {
        switch self {
        case .latestSeries(let items),
                .onAirTvs(let items),
                .popularSeries(let items),
                .topRatedSeries(let items):
            return items.results
        }
    }
    var count: Int {
        return items.count
    }
    var title: String {
        switch self {
        case .onAirTvs:
            return "Now Airing Series"
        case .latestSeries:
            return "Latest Series"
        case .topRatedSeries:
            return "Top rated Series"
        case .popularSeries:
            return "Popular Series"
        }
    }
}

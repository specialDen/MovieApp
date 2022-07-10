//
//  EndPoints.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 08.02.2022.
//

import Foundation

struct EndPoints {
    
    struct SearchMovies {
        static let topUrl = "https://api.themoviedb.org/3/search/movie?api_key="
        static let endUrl = "&query="
        
    }
    
    struct discoverMovies{
        static let baseUrl = "https://api.themoviedb.org/3/movie/popular?api_key="
        static let endUrl = "&page="
    }
    
    struct discoverSeries {
        static let baseUrl = "https://api.themoviedb.org/3/tv/popular?api_key="
    }
}

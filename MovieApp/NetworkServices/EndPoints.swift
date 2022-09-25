//
//  EndPoints.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 08.02.2022.
//

import Foundation

protocol EndPointProtocol {
    var completeURL: String { get }
}

enum MoviesEndpoint: EndPointProtocol {
    
    case getTrendingMovies
    case getUpcomingMovies
    case getLatest
    case getTopRated
    case getPopularMovies
    case getGenres
    case searchForMovies(searchFilter: String)
    case getMovies(withGenreId: Int)
    
    private var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
//    case trendingMovies(_ movies: MoviesData)
//    case upcomingMovies(_ movies: MoviesData)
//    case latestMovies(_ movies: MoviesData)
//    case topRatedMovies(_ movies: MoviesData)
//    case popularMovies(_ movies: MoviesData)
//    
//    static let allMovieCategories: [MoviesEndpoint] = [.getTrendingMovies, ]
    
//https://api.themoviedb.org/3/movie/latest?api_key=8cfd4da25a104540bb0eb7b00344f1f5&language=en-US
    var completeURL: String {
        switch self {
        case .getTrendingMovies:
            return baseURL + "/3/trending/movie/day?api_key=" + Keys.clientID
        case .getUpcomingMovies:
            return baseURL + "/3/movie/upcoming?api_key=" + Keys.clientID + "&language=en-US&page=1"
        case .getLatest:
            return baseURL + "/3/movie/latest?api_key=" + Keys.clientID + "&language=en-US"
        case .getTopRated:
            return baseURL + "/3/movie/top_rated?api_key=" + Keys.clientID + "&language=en-US&page=1"
        case .getPopularMovies:
            return baseURL + "/3/movie/popular?api_key=" + Keys.clientID + "&language=en-US&page=1"
        case .searchForMovies(let searchString):
            return baseURL + "/3/search/movie?api_key=" + Keys.clientID + "&query=" + searchString
        case .getGenres:
            return baseURL + "/3/genre/movie/list?api_key=" + Keys.clientID + "&language=en-US"
        case .getMovies(let genreId):
            return baseURL + "/3/discover/movie?api_key=" + Keys.clientID + "&language=en-US&sort_by=popularity.desc&include_adult=false&with_genres=" + String(genreId)
        
        }
        
        
        
    }
    
    
}

//https://api.themoviedb.org/3/discover/tv?api_key=8cfd4da25a104540bb0eb7b00344f1f5&language=en-US&sort_by=popularity.desc&include_adult=false&with_genres=18
//
//"https://api.themoviedb.org/3/discover/movie?api_key=8cfd4da25a104540bb0eb7b00344f1f5&language=en-US&sort_by=popularity.desc&include_adult=false&with_genres=Action"

enum SeriesEndpoint: EndPointProtocol {
    
    case getTopRated
    case getPopularSeries
    case getLatest
    case getOnAirTvs
    case getGenres
    case getSeries(withGenreId: Int)
    
    case searchForSeries(searchFilter: String)
    
    private var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
    var completeURL: String {
        switch self {
        case .getLatest:
            return baseURL + "/3/trending/movie/day?api_key=" + Keys.clientID
        case .getOnAirTvs:
            return baseURL + "/3/tv/on_the_air?api_key=" + Keys.clientID + "&language=en-US&page=1"
        case .getTopRated:
            return baseURL + "/3/movie/top_rated?api_key=" + Keys.clientID + "&language=en-US&page=1"
        case .getPopularSeries:
            return baseURL + "/3/tv/popular?api_key=" + Keys.clientID + "&language=en-US&page=1"
        case .searchForSeries(let searchString):
            return baseURL + "/3/search/tv?api_key=" + Keys.clientID + "&query=" + searchString
        case .getGenres:
            return baseURL + "/3/genre/tv/list?api_key=" + Keys.clientID + "&language=en-US"
        case .getSeries(let genreId):
            return baseURL + "/3/discover/tv?api_key=" + Keys.clientID + "&language=en-US&sort_by=popularity.desc&include_adult=false&with_genres=" + String(genreId)
        }        
        
    }

    
    
}

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
    case getMovies(withGenre: GenreModel)
    
    private var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
    
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
        case .getMovies(let genre):
            return baseURL + "/3/discover/movie?api_key=" + Keys.clientID + "&language=en-US&sort_by=popularity.desc&include_adult=false&with_genres=" + String(genre.id)
        
        }
        
        
        
    }
    
    
}


enum SeriesEndpoint: EndPointProtocol {
    
    case getTopRated
    case getPopularSeries
    case getLatest
    case getOnAirTvs
    case getGenres
    case getSeries(withGenre: GenreModel)
    
    case searchForSeries(searchFilter: String)
    
    private var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
    var completeURL: String {
        switch self {
        case .getLatest:
            return baseURL + "/3/trending/tv/day?api_key=" + Keys.clientID
        case .getOnAirTvs:
            return baseURL + "/3/tv/on_the_air?api_key=" + Keys.clientID + "&language=en-US&page=1"
        case .getTopRated:
            return baseURL + "/3/tv/top_rated?api_key=" + Keys.clientID + "&language=en-US&page=1"
        case .getPopularSeries:
            return baseURL + "/3/tv/popular?api_key=" + Keys.clientID + "&language=en-US&page=1"
        case .searchForSeries(let searchString):
            return baseURL + "/3/search/tv?api_key=" + Keys.clientID + "&query=" + searchString
        case .getGenres:
            return baseURL + "/3/genre/tv/list?api_key=" + Keys.clientID + "&language=en-US"
        case .getSeries(let genre):
            return baseURL + "/3/discover/tv?api_key=" + Keys.clientID + "&language=en-US&sort_by=popularity.desc&include_adult=false&with_genres=" + String(genre.id)
        }        
        
    }
}


enum SearchEndpoint: EndPointProtocol {
    case searchForSeries(searchFilter: String)
    case searchForMovies(searchFilter: String)
    case searchByKeyWord(keyWord: String)
    case getTopRatedSeries
    case getTopRatedMovies
    
    private var baseURL: String {
        return "https://api.themoviedb.org"
    }
    var completeURL: String {
        switch self {
        case .searchForSeries(searchFilter: let searchString):
            return baseURL + "/3/search/tv?api_key=" + Keys.clientID + "&query=" + searchString
        case .searchForMovies(searchFilter: let searchString):
            return baseURL + "/3/search/movie?api_key=" + Keys.clientID + "&language=en-US&query=" + searchString + "&page=1"
        case .searchByKeyWord(keyWord: let keyWord):
            return baseURL + "/3/search/tv?api_key=" + Keys.clientID + "&query=" + keyWord
        case .getTopRatedSeries:
            return baseURL + "/3/tv/top_rated?api_key=" + Keys.clientID + "&language=en-US&page=1"
        case .getTopRatedMovies:
            return baseURL + "/3/movie/top_rated?api_key=" + Keys.clientID + "&language=en-US&page=1"
        }
    }
}


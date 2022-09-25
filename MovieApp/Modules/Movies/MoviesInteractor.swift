//
//  MoviesInteractor.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import Foundation

protocol MoviesInteractorProtocol{
    var presenter: MoviesrPresenterInput? {get set}
    var apiManager: NetworkService<MoviesEndpoint>? { get }
    func getMovies()
    func getGenres()
    func getGenreMovies(withId id: Int)
}

class MoviesInteractor: MoviesInteractorProtocol {
    weak var presenter: MoviesrPresenterInput?
    var apiManager: NetworkService<MoviesEndpoint>?
    
    func getMovies() {
        for movieCategory in MovieLists.allCases {
            
            switch movieCategory {
            case .trendingMovies(_):
                performNetworkRequest(.getTrendingMovies)
            case .upcomingMovies(_):
                performNetworkRequest(.getUpcomingMovies)
            case .latestMovies(_):
                performNetworkRequest(.getLatest)
            case .topRatedMovies(_):
                performNetworkRequest(.getTopRated)
            case .popularMovies(_):
                performNetworkRequest(.getPopularMovies)
            }
        }
        
    }
    func getGenres() {
        performNetworkRequest(.getGenres)
    }
    
    func getGenreMovies(withId id: Int){
        performNetworkRequest(.getMovies(withGenreId: id))
    }
    
    
    private func processData(_ movieData: MoviesData, endpoint: MoviesEndpoint)  {

        switch endpoint {
        case .getTrendingMovies:
            self.presenter?.apiFetchSuccess(movies: .trendingMovies(movieData))
        case .getUpcomingMovies:
            self.presenter?.apiFetchSuccess(movies: .upcomingMovies(movieData))
        case .getLatest:
            self.presenter?.apiFetchSuccess(movies: .latestMovies(movieData))
        case .getTopRated:
            self.presenter?.apiFetchSuccess(movies: .topRatedMovies(movieData))
        case .getPopularMovies:
            self.presenter?.apiFetchSuccess(movies: .popularMovies(movieData))
        case .getGenres:
            break
        case .searchForMovies(_):
            break
        case .getMovies(_):
            break
        }

    }
    
    private func performNetworkRequest(_ endpoint: MoviesEndpoint)  {

        switch endpoint {
        case .getLatest:
            apiManager?.networkRequest(from: endpoint, modelType: Movie.self, completion: { [weak self] (result) in
                switch result {
                case .success(let movieData):
                    self?.presenter?.apiFetchSuccess(movies: .latestMovies(MoviesData.init(results: [movieData])))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        case .getGenres:
            apiManager?.networkRequest(from: endpoint, modelType: Genres.self, completion: { [weak self]result in
                switch result {
                case .success(let genres):
                    self?.presenter?.genresFetchSuccess(genres: genres)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            })
        case  .getMovies:
            apiManager?.networkRequest(from: endpoint, modelType: MoviesData.self, completion: { [weak self]result in
                switch result {
                case .success(let movies):
                    self?.presenter?.genresMoviesFetchSuccess(movies: movies.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            })
        default:
            apiManager?.networkRequest(from: endpoint, modelType: MoviesData.self, completion: { [weak self] (result) in
                switch result {
                case .success(let movieData):
                    self?.processData(movieData, endpoint: endpoint)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }) }
    }
}

//
//  SearchInteractor.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import Foundation

protocol SearchInteractorProtocol{
    var presenter: SearchPresenterInput? {get set}
    var apiManager: NetworkService<SearchEndpoint>? { get }
    func getMovies(with searchString: String)
    func getSugestions(for keyWord: String, contentType: ContentType)
    func getSeries(with searchString: String)
    func getTopMovies()
    func getTopSeries()
}

class SearchInteractor: SearchInteractorProtocol {
    
    weak var presenter: SearchPresenterInput?
    var apiManager: NetworkService<SearchEndpoint>?
    
    func getMovies(with searchString: String) {
        performNetworkRequest(.searchForMovies(searchFilter: searchString))
        
    }
    func getSugestions(for keyWord: String, contentType: ContentType){
        switch contentType  {
        case .movies:
            moviesSugestions(endpoint: .searchForMovies(searchFilter: keyWord))
        case .series:
            seriesSugestions(endpoint: .searchForSeries(searchFilter: keyWord))
        }
    }
    private func moviesSugestions(endpoint: SearchEndpoint) {
        var contentArray = [String]()
        
        apiManager?.networkRequest(from: endpoint, modelType: MoviesData.self, completion: { [weak self]result in
            switch result {
            case .success(let movies):
                for movie in movies.results {
                    contentArray.append(movie.title ?? "")
                }
                self?.presenter?.suggestionsFetchSuccess(results: contentArray)
            case .failure(let error):
                print(error.localizedDescription)
                print(endpoint.completeURL)
            }
            
        })
    }
    
    private func seriesSugestions(endpoint: SearchEndpoint) {
        var contentArray = [String]()
        
        apiManager?.networkRequest(from: endpoint, modelType: SeriesData.self, completion: { [weak self]result in
            switch result {
            case .success(let series):
                for series in series.results {
                    contentArray.append(series.name ?? "")
                }
                self?.presenter?.suggestionsFetchSuccess(results: contentArray)
            case .failure(let error):
                print(error.localizedDescription)
                print(endpoint.completeURL)
            }
            
        })
    }
    func getSeries(with searchString: String) {
        performNetworkRequest(.searchForSeries(searchFilter: searchString))
    }
    
    func getTopMovies() {
        performNetworkRequest(.getTopRatedMovies)
    }
    
    func getTopSeries() {
        performNetworkRequest(.getTopRatedSeries)
    }

    private func performNetworkRequest(_ endpoint: SearchEndpoint)  {

        switch endpoint {
        case .searchByKeyWord:
            break
        case .searchForMovies(let searchString):
            apiManager?.networkRequest(from: endpoint, modelType: MoviesData.self, completion: { [weak self]result in
                switch result {
                case .success(let movies):
                    self?.presenter?.moviesFetchSuccess(movies: movies.results, searchString: searchString)
                case .failure(let error):
                    print(error.localizedDescription)
                    print(endpoint.completeURL)
                }
                
            })
        case  .searchForSeries(let searchString):
            apiManager?.networkRequest(from: endpoint, modelType: SeriesData.self, completion: { [weak self]result in
                switch result {
                case .success(let series):
                    self?.presenter?.seriesFetchSuccess(series: series.results, searchString: searchString)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            })
        case .getTopRatedSeries:
            apiManager?.networkRequest(from: endpoint, modelType: SeriesData.self, completion: { [weak self]result in
                switch result {
                case .success(let series):
                    self?.presenter?.topMoviesFetchSuccess(series: series.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            })
        case .getTopRatedMovies:
            apiManager?.networkRequest(from: endpoint, modelType: MoviesData.self, completion: { [weak self] (result) in
                switch result {
                case .success(let movies):
                    self?.presenter?.topMoviesFetchSuccess(movies: movies.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
        
    }
    deinit {
        print("Search interactor deinit")
    }
}

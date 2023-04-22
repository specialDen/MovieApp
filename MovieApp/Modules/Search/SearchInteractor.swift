//
//  SearchInteractor.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import Foundation

protocol SearchInteractorProtocol {
  var presenter: SearchPresenterInput? { get set }
  var apiManager: NetworkService<SearchEndpoint>? { get }
  func getMovies(with searchString: String)
  func getSugestions(for keyWord: String, contentType: ContentType)
  func getSeries(with searchString: String)
  func getTopMovies()
  func getTopSeries()
  func getVideo(forSeriesid id: Int, completion: @escaping (String) -> Void)
  func getVideo(forMovieid id: Int, completion: @escaping (String) -> Void)
}

class SearchInteractor: SearchInteractorProtocol {
  weak var presenter: SearchPresenterInput?
  var apiManager: NetworkService<SearchEndpoint>? = NetworkService()

  func getMovies(with searchString: String) {
    performNetworkRequest(.searchForMovies(searchFilter: searchString))
  }

  func getSugestions(for keyWord: String, contentType: ContentType) {
    switch contentType {
    case .movies:
      moviesSugestions(endpoint: .searchForMovies(searchFilter: keyWord))
    case .series:
      seriesSugestions(endpoint: .searchForSeries(searchFilter: keyWord))
    }
  }

  private func moviesSugestions(endpoint: SearchEndpoint) {
    var contentArray = [String]()

    apiManager?.networkRequest(from: endpoint, modelType: MoviesData.self, completion: { [weak self] result in
      switch result {
      case let .success(movies):
        for movie in movies.results {
          contentArray.append(movie.title ?? "")
        }
        self?.presenter?.suggestionsFetchSuccess(results: contentArray)
      case let .failure(error):
        print(error.localizedDescription)
        print(endpoint.completeURL)
      }

    })
  }

  private func seriesSugestions(endpoint: SearchEndpoint) {
    var contentArray = [String]()

    apiManager?.networkRequest(from: endpoint, modelType: SeriesData.self, completion: { [weak self] result in
      switch result {
      case let .success(series):
        for series in series.results {
          contentArray.append(series.name ?? "")
        }
        self?.presenter?.suggestionsFetchSuccess(results: contentArray)
      case let .failure(error):
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

  func getVideo(forSeriesid id: Int, completion: @escaping (String) -> Void) {
    apiManager?
      .networkRequest(from: SearchEndpoint.getSeriesVideo(forSeriesid: id), modelType: VideoData.self) { result in
        switch result {
        case let .success(videos):
          guard let key = videos.results.first?.key else {
            return
          }
          completion(key)
        case let .failure(error):
          print(error.localizedDescription)
        }
      }
  }

  func getVideo(forMovieid id: Int, completion: @escaping (String) -> Void) {
    apiManager?
      .networkRequest(from: SearchEndpoint.getMovieVideo(forMovieid: id), modelType: VideoData.self) { result in
        switch result {
        case let .success(videos):
          guard let key = videos.results.first?.key else {
            return
          }
          completion(key)
        case let .failure(error):
          print(error.localizedDescription)
        }
      }
  }

  //    swiftLint: disable cyclomatic_complexity
  private func performNetworkRequest(_ endpoint: SearchEndpoint) {
    switch endpoint {
    case .searchByKeyWord:
      break
    case let .searchForMovies(searchString):
      apiManager?.networkRequest(from: endpoint, modelType: MoviesData.self, completion: { [weak self] result in
        switch result {
        case let .success(movies):
          self?.presenter?.moviesFetchSuccess(movies: movies.results, searchString: searchString)
        case let .failure(error):
          print(error.localizedDescription)
          print(endpoint.completeURL)
        }

      })
    case let .searchForSeries(searchString):
      apiManager?.networkRequest(from: endpoint, modelType: SeriesData.self, completion: { [weak self] result in
        switch result {
        case let .success(series):
          self?.presenter?.seriesFetchSuccess(series: series.results, searchString: searchString)
        case let .failure(error):
          print(error.localizedDescription)
        }

      })
    case .getTopRatedSeries:
      apiManager?.networkRequest(from: endpoint, modelType: SeriesData.self, completion: { [weak self] result in
        switch result {
        case let .success(series):
          self?.presenter?.topMoviesFetchSuccess(series: series.results)
        case let .failure(error):
          print(error.localizedDescription)
        }

      })
    case .getTopRatedMovies:
      apiManager?.networkRequest(from: endpoint, modelType: MoviesData.self, completion: { [weak self] result in
        switch result {
        case let .success(movies):
          self?.presenter?.topMoviesFetchSuccess(movies: movies.results)
        case let .failure(error):
          print(error.localizedDescription)
        }
      })
    case .getMovieVideo, .getSeriesVideo:
      break
    }
  }

  deinit {
    print("Search interactor deinit")
  }
}

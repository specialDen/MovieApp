//
//  SeriesInteractor.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import Foundation

protocol SeriesInteractorProtocol {
  var presenter: SeriesPresenterInput? { get set }
  var apiManager: NetworkService<SeriesEndpoint>? { get }
  func getSeries()
  func getGenres()
  func getGenreSeries(withGenre genre: GenreModel)
}

class SeriesInteractor: SeriesInteractorProtocol {
  weak var presenter: SeriesPresenterInput?
  var apiManager: NetworkService<SeriesEndpoint>?

  func getSeries() {
    for seriesCategory in SeriesLists.allCases {
      switch seriesCategory {
      case .topRatedSeries:
        performNetworkRequest(.getTopRated)
      case .latestSeries:
        performNetworkRequest(.getLatest)
      case .onAirTvs:
        performNetworkRequest(.getOnAirTvs)
      case .popularSeries:
        performNetworkRequest(.getPopularSeries)
      }
    }
  }

  func getGenres() {
    performNetworkRequest(.getGenres)
  }

  func getGenreSeries(withGenre genre: GenreModel) {
    performNetworkRequest(.getSeries(withGenre: genre))
  }

  private func processData(_ movieData: SeriesData, endpoint: SeriesEndpoint) {
    switch endpoint {
    case .getTopRated:
      presenter?.apiFetchSuccess(articles: .topRatedSeries(movieData))
    case .getPopularSeries:
      presenter?.apiFetchSuccess(articles: .popularSeries(movieData))
    case .getLatest:
      presenter?.apiFetchSuccess(articles: .latestSeries(movieData))
    case .getOnAirTvs:
      presenter?.apiFetchSuccess(articles: .onAirTvs(movieData))
    case .getGenres:
      break
    case .getSeries:
      break
    case .searchForSeries:
      break
    }
  }

  private func performNetworkRequest(_ endpoint: SeriesEndpoint) {
    switch endpoint {
    case .getLatest:
      apiManager?.networkRequest(from: endpoint, modelType: Series.self, completion: { [weak self] result in
        switch result {
        case let .success(seriesData):
          self?.presenter?.apiFetchSuccess(articles: .latestSeries(SeriesData(results: [seriesData])))
        case let .failure(error):
          print(error.localizedDescription)
        }
      })
    case .getGenres:
      apiManager?.networkRequest(from: endpoint, modelType: Genres.self, completion: { [weak self] result in
        switch result {
        case let .success(genres):
          self?.presenter?.genresFetchSuccess(genres: genres)
        case let .failure(error):
          print(error.localizedDescription)
        }

      })
    case let .getSeries(genre):
      apiManager?.networkRequest(from: endpoint, modelType: SeriesData.self, completion: { [weak self] result in
        switch result {
        case let .success(series):
          self?.presenter?.genresSeriesFetchSuccess(series: series.results, genre: genre.name)
        case let .failure(error):
          print(error.localizedDescription)
        }

      })
    default:
      apiManager?.networkRequest(from: endpoint, modelType: SeriesData.self, completion: { [weak self] result in
        switch result {
        case let .success(seriesData):
          self?.processData(seriesData, endpoint: endpoint)
        case let .failure(error):
          print(error.localizedDescription)
        }
      })
    }
  }

  deinit {
    print("series interactor deinit")
  }
}

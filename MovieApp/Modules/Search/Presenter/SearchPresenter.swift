//
//  SearchPresenter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import UIKit

class SearchPresenter: NSObject {
  var collectionManager: SearchTableViewManagerProtocol?
//    var view: SearchViewController?
//    presenter =
  var searchResultVC: SearchResultsViewController?
  var interactor: SearchInteractorProtocol? = SearchInteractor()
  var router: SearchRouterProtocol? = SearchRouter()

  var series: Series?
  var movie: Movie?
  deinit {
    print("Search presenter deinit")
  }
}

extension SearchPresenter: SearchPresenterProtocol {
  func fetchSuggestions(with searchString: String, contentType: ContentType) {
    interactor?.getSugestions(for: searchString, contentType: contentType)
  }

  func viewNeedsMovies() {
    interactor?.getTopMovies()
  }

  func viewNeedsSeries() {
    interactor?.getTopSeries()
  }
}

extension SearchPresenter: SearchPresenterInput {
  func topMoviesFetchSuccess(movies: [Movie]) {
    collectionManager?.setUpSearchresults(withMovies: movies, series: nil)
  }

  func topMoviesFetchSuccess(series: [Series]) {
    collectionManager?.setUpSearchresults(withMovies: nil, series: series)
  }

  func suggestionsFetchSuccess(results: [String]) {
    searchResultVC?.configureSugestions(with: results)
  }

  func moviesFetchSuccess(movies: [Movie], searchString: String) {
    router?.presentSearchSuggestionsVC(with: movies)
  }

  func seriesFetchSuccess(series: [Series], searchString: String) {
    router?.presentSearchSuggestionsVC(with: series)
  }

  func seriesTrailerFetchSuccess(key: String) {
    guard let series else { return }
    router?.presentDecriptionVC(with: series, videoKey: key, navVc: nil)
  }

  func moviesTrailerFetchSuccess(key: String) {
    guard let movie else { return }
    router?.presentDecriptionVC(with: movie, videoKey: key, navVc: nil)
  }
}

extension SearchPresenter: SearchTableViewManagerDelegate {
  func cellClicked(movie: Movie, navVc: UINavigationController?) {
    guard let id = movie.id else { return }
    self.movie = movie
    interactor?.getVideo(forMovieid: id) { [weak self] videoId in
      self?.router?.presentDecriptionVC(with: movie, videoKey: videoId, navVc: navVc)
    }
  }

  func cellClicked(series: Series, navVc: UINavigationController?) {
    guard let id = series.id else { return }
    self.series = series
    interactor?.getVideo(forSeriesid: id) { [weak self] videoId in
      self?.router?.presentDecriptionVC(with: series, videoKey: videoId, navVc: navVc)
    }
  }
}

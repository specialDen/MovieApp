//
//  SearchPresenter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import Foundation

class SearchPresenter: NSObject {
  var collectionManager: SearchTableViewManagerProtocol?
//    var view: SearchViewController?
  var searchResultVC: SearchResultsViewController?
  var interactor: SearchInteractorProtocol?
  var router: SearchRouterProtocol?
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
}

extension SearchPresenter: SearchTableViewManagerDelegate {
  func cellClicked(movie: Movie) {
    router?.presentDecriptionVC(with: movie, navVc: nil)
  }

  func cellClicked(series: Series) {
    router?.presentDecriptionVC(with: series, navVc: nil)
  }
}

//
//  SearchPresenterProtocols.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import UIKit

protocol SearchPresenterProtocol: AnyObject {
//    func viewDidLoad()
  var collectionManager: SearchTableViewManagerProtocol? { get set }
  func viewNeedsSeries()
  func viewNeedsMovies()
  func fetchSuggestions(with searchString: String, contentType: ContentType)
}

protocol SearchPresenterInput: AnyObject {
  func suggestionsFetchSuccess(results: [String])
  func moviesFetchSuccess(movies: [Movie], searchString: String)
  func seriesFetchSuccess(series: [Series], searchString: String)
  func topMoviesFetchSuccess(movies: [Movie])
  func topMoviesFetchSuccess(series: [Series])
  func seriesTrailerFetchSuccess(key: String)
  func moviesTrailerFetchSuccess(key: String)
}

// manager to presenter
protocol SearchTableViewManagerDelegate: AnyObject {
  func cellClicked(movie: Movie, navVc: UINavigationController?)
  func cellClicked(series: Series, navVc: UINavigationController?)
}

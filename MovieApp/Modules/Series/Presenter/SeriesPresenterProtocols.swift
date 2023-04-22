//
//  SeriesPresenterProtocols.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 21.09.2022.
//

import UIKit

// view to presenter
protocol SeriesPresenterProtocol: AnyObject {
  func viewDidLoad()
  var collectionManager: SeriesCollectionViewManagerProtocol? { get set }
  func viewNeedsGenres()
}

// interactor to presenter
protocol SeriesPresenterInput: AnyObject {
  func apiFetchSuccess(articles: SeriesLists)
  func handleError(error: Error)
  func genresFetchSuccess(genres: Genres)
  func genresSeriesFetchSuccess(series: [Series], genre: String)
  func seriesTrailerFetchSuccess(key: String)
}

// manager to presenter
protocol SeriesCollectionViewManagerDelegate: AnyObject {
  func cellClicked(series: Series, navVC: UINavigationController?)
}

// GenreVC to presenter
protocol SeriesGenrePresenterProtocol: AnyObject {
  func getSeries(withGenre genre: GenreModel)
}

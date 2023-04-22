//
//  MoviesPresenterProtocols.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 10.09.2022.
//

import Foundation
import UIKit

// view to presenter
protocol MoviesPresenterProtocol: AnyObject {
  func viewDidLoad()
  var collectionManager: MoviesCollectionViewManagerProtocol? { get set }
  func viewNeedsGenres()
}

// interactor to presenter
protocol MoviesPresenterInput: AnyObject {
  func apiFetchSuccess(movies: MovieLists)
  func handleError(error: Error)
  func genresFetchSuccess(genres: Genres)
  func genresMoviesFetchSuccess(movies: [Movie], genre: String)
  func moviesTrailerFetchSuccess(key: String)
}

// manager to presenter
protocol MoviesCollectionViewManagerDelegate: AnyObject {
  func cellClicked(movie: Movie, navVc: UINavigationController?)
}

// GenreVC to presenter
protocol MovieGenrePresenterProtocol: AnyObject {
  func getMovies(withGenre genre: GenreModel)
}

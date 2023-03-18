//
//  MoviesPresenterProtocols.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 10.09.2022.
//

import Foundation

// view to presenter
protocol MoviesPresenterProtocol: AnyObject {
  func viewDidLoad()
  var collectionManager: MoviesCollectionViewManagerProtocol? { get set }
  func viewNeedsGenres()
}

// interactor to presenter
protocol MoviesrPresenterInput: AnyObject {
  func apiFetchSuccess(movies: MovieLists)
  func handleError(error: Error)
  func genresFetchSuccess(genres: Genres)
  func genresMoviesFetchSuccess(movies: [Movie], genre: String)
}

// manager to presenter
protocol MoviesCollectionViewManagerDelegate: AnyObject {
  func cellClicked(movie: Movie)
}

// GenreVC to presenter
protocol MovieGenrePresenterProtocol: AnyObject {
  func getMovies(withGenre genre: GenreModel)
}

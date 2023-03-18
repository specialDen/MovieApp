//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import Foundation

class MoviesPresenter {
  var router: MoviesRouterProtocol?

  var interactor: MoviesInteractorProtocol?
  var movieSections: [MovieLists] = []
  var collectionManager: MoviesCollectionViewManagerProtocol?

  deinit {
    print("movies presenter deinit")
  }
}

extension MoviesPresenter: MoviesPresenterProtocol {
  func viewDidLoad() {
    // fetch data from interactor
    interactor?.getMovies()
  }

  func viewNeedsGenres() {
    interactor?.getGenres()
  }
}

extension MoviesPresenter: MoviesCollectionViewManagerDelegate {
  func cellClicked(movie: Movie) {
    router?.presentDecriptionVC(with: movie, navVc: nil)
  }
}

extension MoviesPresenter: MoviesrPresenterInput {
  func apiFetchSuccess(movies: MovieLists) {
    // Manager- setupMovies
    if let index = movieSections.firstIndex(where: { $0.title == movies.title }) {
      movieSections[index] = movies
    } else {
      movieSections.append(movies)
    }
    collectionManager?.setUpMovies(movieSections)
  }

  func handleError(error: Error) {
    // ??
  }

  func genresFetchSuccess(genres: Genres) {
    router?.presentGenresVC(with: genres)
  }

  func genresMoviesFetchSuccess(movies: [Movie], genre: String) {
    router?.presentMovies(movies, ofGenre: genre)
  }
}

extension MoviesPresenter: MovieGenrePresenterProtocol {
  func getMovies(withGenre genre: GenreModel) {
    interactor?.getGenreMovies(withGenre: genre)
  }
}

//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import Foundation
import UIKit

class MoviesPresenter {
  var router: MoviesRouterProtocol? = MoviesRouter()

  var interactor: MoviesInteractorProtocol? = MoviesInteractor()

  var movieSections: [MovieLists] = []
  var collectionManager: MoviesCollectionViewManagerProtocol?
  var movie: Movie?
  var navVc: UINavigationController?

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
  func cellClicked(movie: Movie, navVc: UINavigationController?) {
    self.movie = movie
    self.navVc = navVc
    guard let id = movie.id else { return }
    interactor?.getVideo(forMovieid: id) { [weak self] videoId in
      self?.router?.presentDecriptionVC(with: movie, videoKey: videoId, navVc: navVc)
    }
  }
}

extension MoviesPresenter: MoviesPresenterInput {
  func moviesTrailerFetchSuccess(key: String) {
//    guard let movie else { return }
  }

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

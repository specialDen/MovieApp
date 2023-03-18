//
//  MoviesRouter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 02.02.2022.
//

import Foundation
import UIKit

protocol MoviesRouterProtocol {
  var view: UIViewController? { get }
  func presentDecriptionVC(with movie: Movie, navVc: UINavigationController?)
  func presentGenresVC(with genres: Genres)
  func presentMovies(_ movies: [Movie], ofGenre genre: String)
}

class MoviesRouter: MoviesRouterProtocol {
  func presentMovies(_ movies: [Movie], ofGenre genre: String) {
    DispatchQueue.main.async {
      let moviesListVC = GenreMoviesCollectionVC()
      moviesListVC.title = genre
      moviesListVC.configure(withMovies: movies)
      self.view?.navigationController?.pushViewController(moviesListVC, animated: true)
    }
  }

  var view: UIViewController?

  func presentDecriptionVC(with movie: Movie, navVc: UINavigationController?) {
    let decriptionVC = TitlePreviewViewController()
    decriptionVC.configureDescription(with: movie)
    if let navVc = navVc {
      navVc.pushViewController(decriptionVC, animated: true)
    } else {
      view?.navigationController?.pushViewController(decriptionVC, animated: true)
    }
  }

  func presentGenresVC(with genres: Genres) {
    DispatchQueue.main.async {
      let genresVC = MoviesAssembly.createGenresVC(view: self.view)
      genresVC.configureGenres(with: genres.genres)
      self.view?.navigationController?.pushViewController(genresVC, animated: true)
    }
  }

  deinit {
    print("movies router deinit")
  }
}

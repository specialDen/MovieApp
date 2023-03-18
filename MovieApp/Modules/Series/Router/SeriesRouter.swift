//
//  SeriesRouter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 02.02.2022.
//

import UIKit

protocol SeriesRouterProtocol {
  var view: UIViewController? { get }
  func presentDecriptionVC(with series: Series, navVc: UINavigationController?)
  func presentSeries(_ series: [Series], ofGenre genre: String)
  func presentGenresVC(with genres: Genres)
}

class SeriesRouter: SeriesRouterProtocol {
  var view: UIViewController?

  func presentSeries(_ series: [Series], ofGenre genre: String) {
    DispatchQueue.main.async {
      let seriesListVC = GenreSeriesCollectionVC()
      seriesListVC.title = genre
      seriesListVC.configure(withMovies: series)
      self.view?.navigationController?.pushViewController(seriesListVC, animated: true)
    }
  }

  func presentDecriptionVC(with series: Series, navVc: UINavigationController?) {
    let decriptionVC = TitlePreviewViewController()
    decriptionVC.configureDescription(with: series)
    if let navVc = navVc {
      navVc.pushViewController(decriptionVC, animated: true)
    } else {
      view?.navigationController?.pushViewController(decriptionVC, animated: true)
    }
  }

  func presentGenresVC(with genres: Genres) {
    DispatchQueue.main.async {
      let genresVC = SeriesAssembly.createGenresVC(view: self.view)
      genresVC.configureGenres(with: genres.genres)
      self.view?.navigationController?.pushViewController(genresVC, animated: true)
    }
  }

  deinit {
    print("movies router deinit")
  }
}

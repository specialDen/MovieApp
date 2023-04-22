//
//  SeriesPresenter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import UIKit

class SeriesPresenter {
  var router: SeriesRouterProtocol? = SeriesRouter()

  var interactor: SeriesInteractorProtocol? = SeriesInteractor()
  var seriesSections: [SeriesLists] = []
  var collectionManager: SeriesCollectionViewManagerProtocol?
  var series: Series?

//  var navVC: UINavigationController?
  deinit {
    print("series presenter deinit")
  }
}

extension SeriesPresenter: SeriesPresenterProtocol {
  func viewDidLoad() {
    // fetch data from interactor
    interactor?.getSeries()
//        collectionManager.delegate = self
  }

  func viewNeedsGenres() {
    interactor?.getGenres()
  }
}

extension SeriesPresenter: SeriesCollectionViewManagerDelegate {
  func cellClicked(series: Series, navVC: UINavigationController?) {
    self.series = series
    guard let id = series.id else { return }
    interactor?.getVideo(forSeriesid: id) { [weak self] videoId in
      self?.router?.presentDecriptionVC(with: series, videoKey: videoId, navVc: navVC)
    }
  }
}

extension SeriesPresenter: SeriesPresenterInput {
  func apiFetchSuccess(articles: SeriesLists) {
    // Manager- setupMovies
    if let index = seriesSections.firstIndex(where: { $0.title == articles.title }) {
      seriesSections[index] = articles
    } else {
      seriesSections.append(articles)
    }
    collectionManager?.setUpMovies(seriesSections)
  }

  func seriesTrailerFetchSuccess(key: String) {
    // Router - present description view
    guard let series else { return }
    router?.presentDecriptionVC(with: series, videoKey: key, navVc: nil)
  }

  func handleError(error: Error) {
    // ??
  }

  func genresFetchSuccess(genres: Genres) {
    router?.presentGenresVC(with: genres)
  }

  func genresSeriesFetchSuccess(series: [Series], genre: String) {
    router?.presentSeries(series, ofGenre: genre)
  }
}

extension SeriesPresenter: SeriesGenrePresenterProtocol {
  func getSeries(withGenre genre: GenreModel) {
    interactor?.getGenreSeries(withGenre: genre)
  }
}

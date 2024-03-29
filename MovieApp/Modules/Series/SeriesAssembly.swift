//
//  SeriesAssembly.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import UIKit

struct SeriesAssembly {
  static func createSeriesVC() -> UIViewController {
    let seriesViewController = SeriesViewController()
    let presenter = SeriesPresenter()
    let interactor = SeriesInteractor()
    let router = SeriesRouter()
    let collectionViewManager = SeriesCollectionViewManager()

    presenter.interactor = interactor
    presenter.router = router
    interactor.presenter = presenter
    presenter.collectionManager = collectionViewManager
    seriesViewController.presenter = presenter
    interactor.apiManager = NetworkService()
    router.view = seriesViewController
    collectionViewManager.delegate = presenter

    return seriesViewController
  }

  static func createGenresVC(view: UIViewController?) -> GenresViewController {
    let genresVC = GenresViewController()
    let interactor = SeriesInteractor()
    let presenter = SeriesPresenter()
    let router = SeriesRouter()

    genresVC.seriesPresenter = presenter
    genresVC.seriesPresenter?.interactor = interactor
    interactor.apiManager = NetworkService()
    interactor.presenter = presenter
    presenter.router = router
    router.view = view

    return genresVC
  }
}

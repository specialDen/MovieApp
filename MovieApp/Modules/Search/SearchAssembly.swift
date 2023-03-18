//
//  SearchAssembly.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import UIKit

struct SearchAssembly {
  static func createSearchVC() -> UIViewController {
    let searchViewController = SearchViewController()
    let presenter = SearchPresenter()
    let interactor = SearchInteractor()
    let searchResultsVC = SearchResultsViewController()
    let tableViewManager = SearchTableViewManager()
    let searchSuggestionsVC = SearchSuggestionsVC()
    let router = SearchRouter()
//        var searchResultVC: SearchResultsViewController?

    presenter.interactor = interactor
    presenter.searchResultVC = searchResultsVC
    presenter.router = router
    presenter.collectionManager = tableViewManager

    tableViewManager.delegate = presenter

    searchResultsVC.searchPresenter = presenter

    searchViewController.searchResultsVC = searchResultsVC
    searchViewController.presenter = presenter

    interactor.presenter = presenter
    interactor.apiManager = NetworkService()

    searchSuggestionsVC.router = router

    router.view = searchViewController
    router.searchSuggestionsVC = searchSuggestionsVC

    return searchViewController
  }
}

//
//  SearchRouter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import UIKit

protocol SearchRouterProtocol: AnyObject {
  var view: UIViewController? { get }
  var searchSuggestionsVC: SearchSuggestionsVC? { get }
  func presentDecriptionVC(with movie: Movie, videoKey: String, navVc: UINavigationController?)
  func presentDecriptionVC(with series: Series, videoKey: String, navVc: UINavigationController?)
//    func presentGenresVC(with genres: Genres)
  func presentSearchSuggestionsVC(with movies: [Movie])
  func presentSearchSuggestionsVC(with series: [Series])
}

class SearchRouter: SearchRouterProtocol {
  func presentSearchSuggestionsVC(with movies: [Movie]) {
    searchSuggestionsVC?.movies = movies
    searchSuggestionsVC?.updateContentType(with: .movies)
    DispatchQueue.main.async {
      guard let searchSuggestionsVC = self.searchSuggestionsVC else { return }
      self.view?.navigationController?.pushViewController(searchSuggestionsVC, animated: true)
    }
  }

  func presentSearchSuggestionsVC(with series: [Series]) {
    DispatchQueue.main.async {
      self.searchSuggestionsVC?.series = series
      self.searchSuggestionsVC?.updateContentType(with: .series)
      guard let searchSuggestionsVC = self.searchSuggestionsVC else { return }
      self.view?.navigationController?.pushViewController(searchSuggestionsVC, animated: true)
    }
  }

  var view: UIViewController?
  var searchSuggestionsVC: SearchSuggestionsVC?
  func presentDecriptionVC(with movie: Movie, videoKey: String, navVc: UINavigationController?) {
    DispatchQueue.main.async {
      let decriptionVC = TitlePreviewViewController()
      decriptionVC.configureDescription(with: movie, videoKey: videoKey)
      if let navVc = navVc {
        navVc.pushViewController(decriptionVC, animated: true)
      } else {
        self.view?.navigationController?.pushViewController(decriptionVC, animated: true)
      }
    }
  }

  func presentDecriptionVC(with series: Series, videoKey: String, navVc: UINavigationController?) {
    let decriptionVC = TitlePreviewViewController()
    decriptionVC.configureDescription(with: series, videoKey: videoKey)
    if let navVc = navVc {
      navVc.pushViewController(decriptionVC, animated: true)
    } else {
      view?.navigationController?.pushViewController(decriptionVC, animated: true)
    }
  }
}

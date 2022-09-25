//
//  SeriesPresenter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import Foundation


class SeriesPresenter  {
    var router: SeriesRouterProtocol?
    
    var interactor: SeriesInteractorProtocol?
    var seriesSections: [SeriesLists] = []
    var collectionManager: SeriesCollectionViewManagerProtocol?
    
    
}

extension SeriesPresenter: SeriesPresenterProtocol {
    func viewDidLoad() {
        //fetch data from interactor
        interactor?.getSeries()
    }
    
    
    
}

extension SeriesPresenter: SeriesCollectionViewManagerDelegate {
    func cellClicked(article: Series?) {
        // Router - present description view
        
    }
    
    
}

extension SeriesPresenter: SeriesPresenterInput {
    func apiFetchSuccess(articles: SeriesLists) {
        //Manager- setupMovies
        if let index = seriesSections.firstIndex(where: {$0.title == articles.title}) {
            seriesSections[index] = articles
        } else {
            seriesSections.append(articles)
        }
        self.collectionManager?.setUpMovies(seriesSections)
    }
    
    func handleError(error: Error) {
        //??
    }
    
    
}

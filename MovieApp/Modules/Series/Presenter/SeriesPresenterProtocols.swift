//
//  SeriesPresenterProtocols.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 21.09.2022.
//

import Foundation

// view to presenter
protocol SeriesPresenterProtocol: AnyObject {
    func viewDidLoad()
    var collectionManager: SeriesCollectionViewManagerProtocol? { get set }
    
}

//interactor to presenter
protocol SeriesPresenterInput: AnyObject {
    func apiFetchSuccess(articles: SeriesLists)
    func handleError(error: Error)
}


//manager to presenter
protocol SeriesCollectionViewManagerDelegate: AnyObject {
    func cellClicked(article: Series?)
}

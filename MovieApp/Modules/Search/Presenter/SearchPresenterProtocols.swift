//
//  SearchPresenterProtocols.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import Foundation


protocol SearchPresenterProtocol: AnyObject {
//    func viewDidLoad()
    var collectionManager: SearchTableViewManagerProtocol? { get set }
    func viewNeedsSeries()
    func viewNeedsMovies()
    func fetchSuggestions(with searchString: String, contentType: ContentType)
}

protocol SearchPresenterInput: AnyObject {
    func suggestionsFetchSuccess(results: [String])
    func moviesFetchSuccess(movies: [Movie], searchString: String)
    func seriesFetchSuccess(series: [Series], searchString: String)
    func topMoviesFetchSuccess(movies: [Movie])
    func topMoviesFetchSuccess(series: [Series])
}

//manager to presenter
protocol SearchTableViewManagerDelegate: AnyObject {
    func cellClicked(movie: Movie)
    func cellClicked(series: Series)
}

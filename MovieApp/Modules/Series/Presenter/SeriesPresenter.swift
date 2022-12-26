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
    
    deinit {
        print("series presenter deinit")
    }
}

extension SeriesPresenter: SeriesPresenterProtocol {
    func viewDidLoad() {
        //fetch data from interactor
        interactor?.getSeries()
//        collectionManager.delegate = self
    }
    
    func viewNeedsGenres() {
        interactor?.getGenres()
    }
    
}

extension SeriesPresenter: SeriesCollectionViewManagerDelegate {
    func cellClicked(series: Series) {
        // Router - present description view
        router?.presentDecriptionVC(with: series, navVc: nil)
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
    
    func genresFetchSuccess(genres: Genres){
        self.router?.presentGenresVC(with: genres)
    }
    func genresSeriesFetchSuccess(series: [Series], genre: String) {
        self.router?.presentSeries(series, ofGenre: genre)
    }
    
}

extension SeriesPresenter: SeriesGenrePresenterProtocol {
    func getSeries(withGenre genre: GenreModel) {
        interactor?.getGenreSeries(withGenre: genre)
    }
}

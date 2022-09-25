//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import Foundation

//protocol AnyPresenter{
//    var router: MoviesRouterProtocol? { get set }
//    var interactor: MoviesInteractorProtocol? { get set }
//    var view: MoviesViewInput? { get set }
//    func updateViewData() -> MoviesData?
//
//}

class MoviesPresenter  {
    var router: MoviesRouterProtocol?
    
    var interactor: MoviesInteractorProtocol?
    var movieSections: [MovieLists] = []
//    var view: MoviesViewInput?
    var collectionManager: MoviesCollectionViewManagerProtocol?
//    func updateViewData() -> MoviesData? {
//        let movies = interactor?.getMovies()
//        return movies
//    }
    
    
}

extension MoviesPresenter: MoviesPresenterProtocol {
    func viewDidLoad() {
        //fetch data from interactor
        interactor?.getMovies()
    }
    
    func viewNeedsGenres() {
        interactor?.getGenres()
    }
    
    
}

extension MoviesPresenter: MoviesCollectionViewManagerDelegate {
    func cellClicked(article: Movie?) {
        // Router - present deccription view
        
    }
    
    
}

extension MoviesPresenter: MoviesrPresenterInput {
    func apiFetchSuccess(movies: MovieLists) {
        //Manager- setupMovies
        if let index = movieSections.firstIndex(where: {$0.title == movies.title}) {
            movieSections[index] = movies
        } else {
            movieSections.append(movies)
        }
//        movieSections?.sections.append(articles)
        self.collectionManager?.setUpMovies(movieSections)
    }
    
    func handleError(error: Error) {
        //??
    }
    
    func genresFetchSuccess(genres: Genres){
        self.router?.presentGenresVC(with: genres)
    }
    func genresMoviesFetchSuccess(movies: [Movie]) {
        
    }
    
}

extension MoviesPresenter: MovieGenrePresenterProtocol {
    func getMovies(withGenreId id: Int) {
        interactor?.getGenreMovies(withId: id)
    }
    
    
}

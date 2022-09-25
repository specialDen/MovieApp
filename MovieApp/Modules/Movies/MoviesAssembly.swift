//
//  MoviesAssembly.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import UIKit

struct MoviesAssembly {
    static func createMoviesVC() -> UIViewController {
        let moviesViewController = MoviesViewController()
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor()
        let router = MoviesRouter()
        let collectionViewManager = MoviesCollectionViewManager()
        
        
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        presenter.collectionManager = collectionViewManager
        moviesViewController.presenter = presenter
        interactor.apiManager = NetworkService()
        router.view = moviesViewController

        
        return moviesViewController
    }
    
    static func createGenresVC()-> GenresViewController{
        let genresVC = GenresViewController()
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        
        genresVC.presenter = presenter
        genresVC.presenter?.interactor = interactor
        interactor.apiManager = NetworkService()
        interactor.presenter = presenter
        
        return genresVC
    }
}

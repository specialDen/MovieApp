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
        collectionViewManager.delegate = presenter
        
        return moviesViewController
    }
    
    static func createGenresVC(view: UIViewController?)-> GenresViewController{
        let genresVC = GenresViewController()
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
        
        genresVC.moviesPresenter = presenter
        genresVC.moviesPresenter?.interactor = interactor
        interactor.apiManager = NetworkService()
        interactor.presenter = presenter
        presenter.router = router
        router.view = view
        
        return genresVC
    }
}

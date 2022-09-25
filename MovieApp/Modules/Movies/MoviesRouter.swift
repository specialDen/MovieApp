//
//  MoviesRouter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 02.02.2022.
//

import Foundation
import UIKit


protocol MoviesRouterProtocol {
    var view: UIViewController? { get }
    func presentDecriptionVC(with movie: Movie)
    func presentGenresVC(with genres: Genres)
}
class MoviesRouter: MoviesRouterProtocol {
    
    var view: UIViewController?
    
    func presentDecriptionVC(with movie: Movie) {
        let decriptionVC = TitlePreviewViewController()
        decriptionVC.configureDescription(with: movie)
        view?.navigationController?.pushViewController(decriptionVC, animated: true)
    }
    
    func presentGenresVC(with genres: Genres){
        DispatchQueue.main.async {
            let genresVC = MoviesAssembly.createGenresVC()
            genresVC.configureGenres(with: genres.genres)
            self.view?.navigationController?.pushViewController(genresVC, animated: true)
        }
        
    }

}

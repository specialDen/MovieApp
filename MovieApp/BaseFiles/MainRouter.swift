//
//  MainRouter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? {get}
    static func start() -> AnyRouter
}

class MainRouter {
    var entry: MainTabBarController = MainTabBarController()
    
//    entry = MainTabBarController()
    static func start() -> MainRouter {
        let router = MainRouter()
        
        return router
    }
}

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        view.backgroundColor = .cyan
    }
    
    private func setupTabs() {
        let moviesControllers = UINavigationController(rootViewController: MoviesAssembly.createMoviesVC())
        let seriesControllers = UINavigationController(rootViewController: SeriesViewController())
        let favouritesControllers = UINavigationController(rootViewController: MoviesViewController())
        let settingsControllers = UINavigationController(rootViewController: SeriesViewController())
        
        setViewControllers([moviesControllers, seriesControllers, favouritesControllers, settingsControllers], animated: false)
        
        moviesControllers.title  = "Movies"
        seriesControllers.title = "Series"
        favouritesControllers.title  = "Favourites"
        settingsControllers.title = "Settings"
    }
}

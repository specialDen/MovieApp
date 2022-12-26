//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.09.2022.
//

import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    func createLandingPage(scene: UIWindowScene)
    func createHomePages(scene: UIWindowScene)
}

final class AppCoordinator {
    var window: UIWindow?
}

extension AppCoordinator {
    private func createMoviesVC() -> UINavigationController {
        let moviesViewController = MoviesAssembly.createMoviesVC()
        moviesViewController.title = "Movies"
        moviesViewController.tabBarItem = UITabBarItem(title: "Movies",
                                                       image: UIImage.tabBarItems.movies,
                                                       selectedImage:  UIImage.tabBarItems.movies)
        let navController = UINavigationController(rootViewController: moviesViewController)
        return navController
    }
    private func createSeriesVC()-> UINavigationController {
        let tvSeriesViewController = SeriesAssembly.createSeriesVC()
        tvSeriesViewController.title = "Series"
        tvSeriesViewController.tabBarItem = UITabBarItem(title: "Series",
                                                       image: UIImage.tabBarItems.series,
                                                       selectedImage:  UIImage.tabBarItems.series)
        return UINavigationController(rootViewController: tvSeriesViewController)
    }
    private func createSettingsVC() -> UINavigationController {
        let settingsViewController = MoviesAssembly.createMoviesVC()
        settingsViewController.title = "Settings"
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings",
                                                       image: UIImage.tabBarItems.settings,
                                                       selectedImage:  UIImage.tabBarItems.settings)
        return UINavigationController(rootViewController: settingsViewController)
    }
    private func createFavouritesVC() -> UINavigationController {
        let favouritesViewController = MoviesAssembly.createMoviesVC()
        favouritesViewController.title = "Favourites"
        favouritesViewController.tabBarItem = UITabBarItem(title: "Favourites",
                                                       image: UIImage.tabBarItems.favourites,
                                                       selectedImage:  UIImage.tabBarItems.favourites)
        return UINavigationController(rootViewController: favouritesViewController)
    }
    private func createSearchVC() -> UINavigationController {
        let searchViewController = SearchAssembly.createSearchVC()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(title: "Search",
                                                       image: UIImage.tabBarItems.search,
                                                       selectedImage:  UIImage.tabBarItems.search)
        return UINavigationController(rootViewController: searchViewController)
    }
    private func createTabBarVC() -> UITabBarController {
        let tabBarVC = UITabBarController()
        UITabBar.appearance().tintColor = UIColor.tintColor
        tabBarVC.viewControllers = [createMoviesVC(), createSeriesVC(),createSearchVC(), createFavouritesVC(), createSettingsVC()]
        
        return tabBarVC
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    func createLandingPage(scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
//        window?.rootViewController = signup
        window?.makeKeyAndVisible()
    }
    
    func createHomePages(scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        window?.rootViewController = createTabBarVC()
        window?.makeKeyAndVisible()
    }
    
    
}

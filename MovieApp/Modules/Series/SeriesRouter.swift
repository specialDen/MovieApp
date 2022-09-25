//
//  SeriesRouter.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 02.02.2022.
//

import UIKit

protocol SeriesRouterProtocol {
    var view: UIViewController? { get }
    func presentDecriptionVC(with movie: Series)
}
struct SeriesRouter: SeriesRouterProtocol {
    
    var view: UIViewController?
    
    func presentDecriptionVC(with series: Series) {
        let decriptionVC = TitlePreviewViewController()
        decriptionVC.configureDescription(with: series)
        view?.navigationController?.pushViewController(decriptionVC, animated: true)
    }

}

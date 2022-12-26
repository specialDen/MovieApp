//
//  UIImageExtensions.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.09.2022.
//

import UIKit

extension UIImage {
    enum tabBarItems {
        static var movies: UIImage { UIImage(systemName: "tv.circle") ?? UIImage() }
        static var series: UIImage { UIImage(systemName: "play.tv") ?? UIImage() }
        static var favourites: UIImage { UIImage(systemName: "heart") ?? UIImage() }
        static var profile: UIImage { UIImage(systemName: "person.crop.circle") ?? UIImage() }
        static var settings: UIImage { UIImage(systemName: "gear") ?? UIImage() }
        static var search: UIImage { UIImage(systemName: "magnifyingglass") ?? UIImage() }
    }
}

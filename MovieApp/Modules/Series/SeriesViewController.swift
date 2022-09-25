//
//  SeriesViewController.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import UIKit

protocol SeriesViewInput: AnyObject {
    var presenter: MoviesPresenter? {get set }
}

class SeriesViewController: BaseViewController {
    var presenter: SeriesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.presenter?.collectionManager?.setUpCollectionView(collectionView: self.collectionView)
        setUpUI()
        
    }
}

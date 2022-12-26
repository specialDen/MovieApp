//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 02.02.2022.
//

import UIKit

//presenter to view
protocol MoviesViewInput: AnyObject {
    var presenter: MoviesPresenter? {get set }
}

class MoviesViewController: BaseViewController {
    var presenter: MoviesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.presenter?.collectionManager?.setUpCollectionView(collectionView: self.collectionView)
        setUpUI()
        navigationItem.rightBarButtonItem = .init(title: "Genres", style: .done, target: self, action: #selector(handleRigthBarButtonTap))
    }
    
    @objc func handleRigthBarButtonTap() {
        presenter?.viewNeedsGenres()
    }

    deinit {
        print("movies VC deinit")
    }
    
}


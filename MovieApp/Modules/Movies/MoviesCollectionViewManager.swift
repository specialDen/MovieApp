//
//  MoviesCollectionViewManager.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 10.09.2022.
//

import UIKit

protocol MoviesCollectionViewManagerProtocol {
    func setUpCollectionView(collectionView: UICollectionView)
    func setUpMovies(_ movies: [MovieLists])
}

class MoviesCollectionViewManager: NSObject {
    weak var collectionView: UICollectionView?
    private var movieSections =  [MovieLists]()
}

extension MoviesCollectionViewManager: MoviesCollectionViewManagerProtocol {
    func setUpCollectionView(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.reuseIdentifier)
        self.collectionView?.register(CollectionViewHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeaderReusableView.reuseIdentifier)
    }
    
    func setUpMovies(_ movies: [MovieLists]) {
        self.movieSections = movies
        DispatchQueue.main.async {
            self.collectionView?.reloadData()

        }
    }
    
    
}

extension MoviesCollectionViewManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        // inform the presenter that a cell is tapped
    }
}
extension MoviesCollectionViewManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieSections[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        movieSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.reuseIdentifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let moviePosterPath = movieSections[indexPath.section].items[indexPath.row].poster_path else {
            print("poster not found")
            return cell
        }
        cell.configure(with: moviePosterPath)

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewHeaderReusableView.reuseIdentifier, for: indexPath) as! CollectionViewHeaderReusableView
            header.setup(movieSections[indexPath.section].title)
            return header
            
        default:
            return .init()
        }
        
    }
    
    
}

//
//  SeriesCollectionViewManager.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 21.09.2022.
//

import UIKit

protocol SeriesCollectionViewManagerProtocol {
    func setUpCollectionView(collectionView: UICollectionView)
    func setUpMovies(_ series: [SeriesLists])
}

class SeriesCollectionViewManager: NSObject {
    weak var collectionView: UICollectionView?
    private var seriesSections =  [SeriesLists]()
}

extension SeriesCollectionViewManager: SeriesCollectionViewManagerProtocol {
    func setUpCollectionView(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.reuseIdentifier)
        self.collectionView?.register(CollectionViewHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeaderReusableView.reuseIdentifier)
    }
    
    func setUpMovies(_ series: [SeriesLists]) {
        self.seriesSections = series
        DispatchQueue.main.async {
            self.collectionView?.reloadData()

        }
    }
    
    
}

extension SeriesCollectionViewManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        // inform the presenter that a cell is tapped
    }
}
extension SeriesCollectionViewManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        seriesSections[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        seriesSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.reuseIdentifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let seriesPosterPath = seriesSections[indexPath.section].items[indexPath.row].poster_path else {
            print("poster not found")
            return cell
        }
        cell.configure(with: seriesPosterPath)

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewHeaderReusableView.reuseIdentifier, for: indexPath) as! CollectionViewHeaderReusableView
            header.setup(seriesSections[indexPath.section].title)
            return header
            
        default:
            return .init()
        }
        
    }
    
    
}


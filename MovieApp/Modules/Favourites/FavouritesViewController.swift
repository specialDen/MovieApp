//
//  FavouritesViewController.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import UIKit

class FavouritesViewController: UIViewController {
    let router: MoviesRouterProtocol = MoviesRouter()
    //    var movies: String?
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        navigationController?.navigationBar.prefersLargeTitles =  true
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    
    
    public func configure(withMovies movies: [Movie]) {
        self.movies = movies
        
        collectionView.reloadData()
        
    }
    
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _,_ in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5)
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1),
                                  heightDimension: .fractionalHeight(0.3)),
                subitem: item,
                count: 2)
            group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
            let section = NSCollectionLayoutSection(group: group)
            return section
            
        }
    }
}


extension GenreMoviesCollectionVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        router.presentDecriptionVC(with: movies[indexPath.row], navVc: self.navigationController)
    }
}
extension GenreMoviesCollectionVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.reuseIdentifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let moviePosterPath = movies[indexPath.row].poster_path else {
            print("poster not found")
            return cell
        }
        cell.configure(with: moviePosterPath)
        
        return cell
    }
}




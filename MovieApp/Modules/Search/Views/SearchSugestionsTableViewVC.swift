//
//  SearchSugestionsTableViewVC.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 19.10.2022.
//

import UIKit

// class SearchSugestionsTableViewVC: UITableViewController {
class SearchSuggestionsVC: UIViewController {
  weak var router: SearchRouterProtocol?
  //    var movies: String?
  var movies: [Movie] = []
  var series: [Series] = []
  var contentType: ContentType = .movies

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    collectionView.frame = view.bounds
    navigationController?.navigationBar.prefersLargeTitles = true
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.backgroundColor = .systemBackground
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(
      TitleCollectionViewCell.self,
      forCellWithReuseIdentifier: TitleCollectionViewCell.reuseIdentifier)
    return collectionView
  }()

//    public func configure(withMovies movies: [Movie]) {
//        self.movies = movies
//
//    }

  public func updateContentType(with type: ContentType) {
    DispatchQueue.main.async { [weak self] in
      self?.contentType = type
      self?.collectionView.reloadData()
    }
  }

  private func createLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout { _, _ in
      let item = NSCollectionLayoutItem(layoutSize: .init(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(1)))
      item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5)
      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: .init(
          widthDimension: .fractionalWidth(1),
          heightDimension: .fractionalHeight(0.3)),
        subitem: item,
        count: 2)
      group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
      let section = NSCollectionLayoutSection(group: group)
      return section
    }
  }
}

extension SearchSuggestionsVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch contentType {
    case .movies:
      return movies.count
    case .series:
      return series.count
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    switch contentType {
    case .movies:
      router?.presentDecriptionVC(with: movies[indexPath.row], navVc: navigationController)
    case .series:
      router?.presentDecriptionVC(with: series[indexPath.row], navVc: navigationController)
    }
  }
}

extension SearchSuggestionsVC: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: TitleCollectionViewCell.reuseIdentifier,
      for: indexPath) as? TitleCollectionViewCell
    else {
      return UICollectionViewCell()
    }
    switch contentType {
    case .movies:
      guard let moviePosterPath = movies[indexPath.row].poster_path else {
        print("poster not found")
        return cell
      }
      cell.configure(with: moviePosterPath)
    case .series:
      guard let seriesPosterPath = series[indexPath.row].poster_path else {
        print("poster not found")
        return cell
      }
      cell.configure(with: seriesPosterPath)
    }

    return cell
  }
}

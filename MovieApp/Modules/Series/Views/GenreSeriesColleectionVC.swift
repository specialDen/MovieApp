//
//  GenreSeriesColleectionVC.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 10.10.2022.
//

import UIKit

class GenreSeriesCollectionVC: UIViewController {
  let router: SeriesRouterProtocol = SeriesRouter()
  var series: [Series] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(collectionView)
    collectionView.frame = view.bounds
    navigationController?.navigationBar.prefersLargeTitles = true
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.backgroundColor = .clear
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(
      TitleCollectionViewCell.self,
      forCellWithReuseIdentifier: TitleCollectionViewCell.reuseIdentifier)
    return collectionView
  }()

  public func configure(withMovies series: [Series]) {
    self.series = series

    collectionView.reloadData()
  }

  private func createLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout { _, _ in
      let item = NSCollectionLayoutItem(layoutSize: .init(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(1)))
      item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: .init(
          widthDimension: .fractionalWidth(1),
          heightDimension: .fractionalHeight(0.3)),
        subitem: item,
        count: 2)
      group.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0)
      let section = NSCollectionLayoutSection(group: group)
      return section
    }
  }
}

extension GenreSeriesCollectionVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    series.count
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    router.presentDecriptionVC(with: series[indexPath.row], navVc: navigationController)
  }
}

extension GenreSeriesCollectionVC: UICollectionViewDataSource {
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
    guard let seriesPosterPath = series[indexPath.row].poster_path else {
      print("poster not found")
      return cell
    }
    cell.configure(with: seriesPosterPath)

    return cell
  }
}

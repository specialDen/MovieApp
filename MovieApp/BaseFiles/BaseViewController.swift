//
//  BaseViewController.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 05.09.2022.
//

import UIKit

class BaseViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func setUpUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    collectionView.frame = view.bounds
    navigationController?.navigationBar.prefersLargeTitles = true
//         navigationItem.pre
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }

  var rightBarButtonItem: UIBarButtonItem?

  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.backgroundColor = .clear
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return collectionView
  }()

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }

  private func createLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout { [weak self] _, _ in
      guard let self = self else { return nil }
      let viewWidth = self.view.bounds.width / 3 - 10
      let viewheight = viewWidth * 1.5
      let item =
        NSCollectionLayoutItem(layoutSize: .init(
          widthDimension: .fractionalWidth(1),
          heightDimension: .fractionalHeight(1)
        ))
      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: .init(widthDimension: .absolute(viewWidth), heightDimension: .absolute(viewheight)),
        subitems: [item]
      )
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .groupPaging
      section.interGroupSpacing = 10
      section.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
      section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
      section.supplementariesFollowContentInsets = false
      return section
    }
  }

  private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
    .init(
      layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
  }
}

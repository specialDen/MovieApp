//
//  CollectionViewHeaderReusableView.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 20.09.2022.
//

import UIKit

final class CollectionViewHeaderReusableView: UICollectionReusableView {
  // override var reuseIdentifier: String? =
  private var label: UILabel = {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemGray
    label.text = "Section"
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(label)
//        label.frame = self.bounds
    setConstraints()
    print(CollectionViewHeaderReusableView.reuseIdentifier)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setup(_ title: String) {
    label.text = title
  }

  private func setConstraints() {
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

    ])
  }
}

public extension UICollectionReusableView {
  @objc static var reuseIdentifier: String {
    String(describing: self)
  }
}

//
//  TitleTableViewCell.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
  static let identifier = "TitleTableViewCell"

  private let playButton: UIButton = {
    let button = UIButton()
    var image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
//        image = image?.withTintColor(.label)
    button.setImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .label
    return button
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let titlesPosterUIImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 5
    imageView.layer.borderWidth = 1.5
    imageView.layer.borderColor = UIColor.systemGray.cgColor
    imageView.clipsToBounds = true
    return imageView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(titlesPosterUIImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(playButton)

    setConstraints()
  }

  private func setConstraints() {
    let useableViewWidth = contentView.bounds.size.width - 40
//        let viewHeight = contentView.bounds.size.height
    let titlesPosterUIImageViewConstraints = [
      titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: useableViewWidth * 0.4)
    ]

    let titleLabelConstraints = [
      titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 10),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -10)
    ]

    let playTitleButtonConstraints = [
      playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      playButton.widthAnchor.constraint(equalToConstant: useableViewWidth * 0.2),
      playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ]

    NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
    NSLayoutConstraint.activate(titleLabelConstraints)
    NSLayoutConstraint.activate(playTitleButtonConstraints)
  }

  public func configure(withTitle title: String, posterPath: String) {
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {
      return
    }
    titlesPosterUIImageView.kf.setImage(with: url)
    titleLabel.text = title
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError()
  }
}

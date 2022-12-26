//
//  TitlePreviewViewController.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 05.09.2022.
//

import UIKit

class TitlePreviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .systemBackground
        addSubViews()
        setConstraints()
    }

    private let scrollView = UIScrollView()
    private let contentView = UIView()


    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(downloadButton)
    }

    public func configureDescription(with model: Movie) {
        titleLabel.text = model.title
        overviewLabel.text = model.overview
        guard let posterPath = model.poster_path else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {
            return
        }
        imageView.kf.setImage(with: url)
    }
    public func configureDescription(with model: Series) {
        titleLabel.text = model.name
        overviewLabel.text = model.overview
        guard let posterPath = model.poster_path else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {
            return
        }
        imageView.kf.setImage(with: url)
    }

    private let titleLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.text = "Harry potter"
        return label
    }()

    private let overviewLabel: UILabel = {

        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is the best movie ever to watch as a kid!"
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let downloadButton: UIButton = {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true

        return button
    }()

    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let scrollViewConstraints = [ scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                      scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]

        let contentViewConstraints = [contentView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                                      contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide
                                        .widthAnchor),
                                      contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                                      contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)]
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
    }

    private func setConstraints() {
        setupScrollView()

        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ]

        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]

        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]

        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
            downloadButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]

        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    deinit {
        print("titlePreviewVC deinit")
    }
}

//
//  InformationViewController.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 05.02.2022.
//

import UIKit

final class InformationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setFrames()
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        imageView.image = UIImage(named: "movie.icon")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.sizeToFit()
        
        return scrollView
    }()
    
    private let overviewLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 28.0)
        label.textColor = .brown
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "Overview"
        return label
    }()
    
    private let overviewTextLabel:VerticalAlignLabel = {
        let label = VerticalAlignLabel()
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = .red
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.backgroundColor = .gray
        label.text = "In Scooby-Doo’s greatest adventure yet, see the never-before told story of how lifelong friends Scooby and Shaggy first met and how they joined forces with young detectives Fred, Velma, and Daphne to form the famous Mystery Inc. Now, with hundreds of cases solved, Scooby and the gang face their biggest, toughest mystery ever: an evil plot to unleash the ghost dog Cerberus upon the world. As they race to stop this global “dogpocalypse,” the gang discovers that Scooby has a secret legacy and an epic destiny greater than anyone ever imagined"
//        label.sizeToFit()
        return label
    }()
    
    private let ratingsLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .red
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "5.0"
        return label
    }()
    
    private let releaseYearLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .red
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "2012"
        return label
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .red
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "Shadow Hunters"
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
//        button.imageView?.frame = button.bounds
        button.target(forAction: #selector(didTapButton), withSender: self)
        return button
    }()
    
    private let rateImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 22, height: 20))
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    
    @objc private func didTapButton() {
        
    }
    
    private func setupUI(){
        addSubViews()
//        setConstraints()
    }
    
    private func addSubViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(likeButton)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(ratingsLabel)
        scrollView.addSubview(releaseYearLabel)
        scrollView.addSubview(overviewLabel)
        scrollView.addSubview(overviewTextLabel)
        
        scrollView.addSubview(rateImage)
    }
    
    
    private func setFrames(){
//        print(likeButton.frame.size.width)
        scrollView.frame = view.bounds
        scrollView.contentSize.height = 1.5 * view.frame.maxY
        let edgeInset = 10.0
        
        let imageViewOrigin = CGPoint(x: 0, y: 0)
        let imageViewSize = CGSize(width: view.frame.maxX, height: 1.1 * view.frame.maxX)
        imageView.frame = CGRect(origin: imageViewOrigin, size: imageViewSize)
        
        let likeButtonOrigin = CGPoint(x: edgeInset, y: imageView.frame.size.height + 5.0) + CGPoint(x: 0.0, y: 0.0)
        let likeButtonSize = CGSize(width: 40, height: 40)
        likeButton.frame = CGRect(origin: likeButtonOrigin, size: likeButtonSize)
        
        let titleLabelOrigin = CGPoint(x: likeButtonOrigin.x + likeButtonSize.width + 5, y: likeButtonOrigin.y + 5)
        let titleLabelSize = CGSize(width: imageViewSize.width - likeButtonSize.width - 15, height: 30)
        titleLabel.frame = CGRect(origin: titleLabelOrigin, size: titleLabelSize)
        
        let releaseYearLabelOrigin = CGPoint(x: edgeInset, y: likeButtonOrigin.y + likeButtonSize.height + 5)
        let releaseYearLabelSize = CGSize(width: (view.frame.width - 2 * edgeInset) * 4.5 / 6, height: 35.0)
        releaseYearLabel.frame = CGRect(origin: releaseYearLabelOrigin, size: releaseYearLabelSize)
        
        let rateImageOrigin = CGPoint(x: releaseYearLabelOrigin.x + 3 + releaseYearLabelSize.width + 5, y: releaseYearLabelOrigin.y + 3)
        let rateImageSize = CGSize(width: releaseYearLabelSize.height - 6 , height: releaseYearLabelSize.height - 6)
        rateImage.frame = CGRect(origin: rateImageOrigin, size: rateImageSize)
        
        let ratingsLabelOrigin = CGPoint(x: rateImageOrigin.x + rateImageSize.width + 5, y: releaseYearLabelOrigin.y)
        let ratingsLabelSize = CGSize(width: imageViewSize.width - rateImageOrigin.x -  rateImageSize.width - 5 - edgeInset, height: 35.0)
        ratingsLabel.frame = CGRect(origin: ratingsLabelOrigin, size: ratingsLabelSize)
        
        let overviewLabelOrigin = CGPoint(x: edgeInset, y: releaseYearLabelSize.height + releaseYearLabelOrigin.y + 5)
        let overviewLabelSize = CGSize(width: view.frame.maxX - 2 * edgeInset, height: 40)
        overviewLabel.frame = CGRect(origin: overviewLabelOrigin, size: overviewLabelSize)
        
        let overviewTextLabelOrigin = CGPoint(x: edgeInset, y: overviewLabelSize.height + overviewLabelOrigin.y + 5)
        let overviewTextLabelSize = CGSize(width: scrollView.frame.maxX - 2 * edgeInset, height: scrollView.contentSize.height - overviewLabelOrigin.y - overviewLabelSize.height - 5)
        overviewTextLabel.frame = CGRect(origin: overviewTextLabelOrigin, size: overviewTextLabelSize)
    }
    
    

}

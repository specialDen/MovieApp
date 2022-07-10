//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 02.02.2022.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
  
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    let titleLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = .red
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Shadow hunters"
        return label
    }()
    
    let ratingsLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = .red
        label.textAlignment = .justified
        label.numberOfLines = 1
        label.text = "5.0"
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .brown
//        imageView.layer.cornerRadius = 30
        imageView.layer.cornerRadius = imageView.frame.size.height / 13
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "movie.icon")
        return imageView
    }()
    
    let rateImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 22, height: 20))
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    
    let subView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 12
        return view
    }()
    
    private func addSubViews() {
        contentView.addSubview(subView)
        subView.addSubview(imageView)
        subView.addSubview(titleLabel)
        subView.addSubview(rateImage)
        subView.addSubview(ratingsLabel)
    }
    
    func updateData(with data: CollectionViewEntity){
        guard let urlString = data.imageUrl else {return}
        guard let imageUrl = URL(string: urlString)  else {return}
        titleLabel.text =  data.title
        ratingsLabel.text = data.rate
        imageView.kf.setImage(with: imageUrl)
        
    }
    private func setConstraints(){
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        rateImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            subView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            subView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            imageView.topAnchor.constraint(equalTo: subView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: subView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: subView.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageView.frame.maxX * 1.2),
            
            rateImage.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            rateImage.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 5),
            rateImage.heightAnchor.constraint(equalToConstant: 15),
            rateImage.widthAnchor.constraint(equalToConstant: 15),
            
            ratingsLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            ratingsLabel.leftAnchor.constraint(equalTo: rateImage.rightAnchor, constant: 5),
            ratingsLabel.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -5),
            ratingsLabel.heightAnchor.constraint(equalToConstant: 17),
            
            titleLabel.topAnchor.constraint(equalTo: rateImage.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: subView.rightAnchor,constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -5)

        ])
    }
    
}
extension UICollectionViewCell {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}

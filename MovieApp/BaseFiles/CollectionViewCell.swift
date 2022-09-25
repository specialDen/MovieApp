//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 02.02.2022.
//

import UIKit
import Kingfisher

class TitleCollectionViewCell: UICollectionViewCell {
    
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    //set image
    public func configure(with model: String) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }

        posterImageView.kf.setImage(with: url)
//        posterImageView.image = UIImage(named: "posterImage")
    }
    
}

extension UICollectionViewCell {
    var reuseIdentifier: String {
        String(describing: self)
    }
}

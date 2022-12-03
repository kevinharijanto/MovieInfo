//
//  MovieCell.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 03/12/22.
//

import Foundation
import UIKit

class MovieCell: UICollectionViewCell {
    static let identifier = "MovieCell"
    
    private lazy var movieImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "backdrop")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Alita Battle"
        label.textColor = .white
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "2019"
        label.textColor = .white
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "⭐️ 8.1"
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(movieImageView)
        addSubview(titleLabel)
        addSubview(yearLabel)
        addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: self.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: self.frame.height-45),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            yearLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant: 10),
            ratingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

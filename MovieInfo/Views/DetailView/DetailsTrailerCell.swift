//
//  DetailsTrailerCell.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 04/12/22.
//

import Foundation
import UIKit

class DetailsTrailerCell: UITableViewCell {
    static let identifier = "DetailsTrailerCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test"
        label.textColor = .white
        return label
    }()
    
    private lazy var watchLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "play.fill")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .lightMovieBlue
        
        addSubview(titleLabel)
        addSubview(watchLogo)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            
            watchLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            watchLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
}

extension DetailsTrailerCell {
    func bindViewWith(movie: MovieVideo) {
        titleLabel.text = movie.name
    }
}

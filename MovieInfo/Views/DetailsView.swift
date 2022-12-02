//
//  DetailsView.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 02/12/22.
//

import Foundation
import UIKit

class DetailsView: UIViewController {
    // MARK: - Properties
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var container = UIView()
    
    private lazy var movieImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "backdrop")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "\(movie.title) (\(movie.yearText))"
        label.textColor = .white
        return label
    }()
    
    private lazy var gradientBox: UIView = {
        let box = UIView()
        box.frame = CGRect(x: 0, y: 325, width: view.frame.width, height: 50)
        return box
    }()
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [UIColor.movieBlue.withAlphaComponent(0.0).cgColor,
                           UIColor.movieBlue.cgColor]
        gradient.locations = [0,1]
        gradient.frame.size = self.gradientBox.frame.size
        return gradient
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = movie.genreText
        label.textColor = .white
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = movie.durationText
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.movieBlue
        configureUI()
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        view.addSubview(movieImageView)
        view.addSubview(gradientBox)
        gradientBox.layer.addSublayer(gradient)
        view.addSubview(titleLabel)
        view.addSubview(genreLabel)
        view.addSubview(durationLabel)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            movieImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            movieImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            movieImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            movieImageView.widthAnchor.constraint(equalTo: container.widthAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 2.25),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -45),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            genreLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            
            durationLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            durationLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
        ])
    }
}

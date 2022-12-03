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
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
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
        label.text = "\(movie.durationText) ∙"
        label.textColor = .white
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "⭐️ \(movie.ratingText)"
        label.textColor = .white
        return label
    }()
    
    private lazy var synopsisTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Synopsis"
        label.textColor = .white
        return label
    }()
    
    private lazy var synopsisLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = movie.overview
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var trailersTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Trailers"
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.movieBlue
        configureScrollView()
        configureUI()
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    func configureUI() {
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(gradientBox)
        gradientBox.layer.addSublayer(gradient)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(synopsisTitleLabel)
        contentView.addSubview(synopsisLabel)
        contentView.addSubview(trailersTitleLabel)
        
        let movieDurationAndRating = UIStackView(arrangedSubviews: [durationLabel, ratingLabel])
        movieDurationAndRating.axis = .horizontal
        movieDurationAndRating.translatesAutoresizingMaskIntoConstraints = false
        movieDurationAndRating.alignment = .center
        view.addSubview(movieDurationAndRating)
        
        NSLayoutConstraint.activate([
            
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            movieImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 2.25),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -45),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            movieDurationAndRating.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            movieDurationAndRating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            synopsisTitleLabel.topAnchor.constraint(equalTo: movieDurationAndRating.bottomAnchor, constant: 20),
            synopsisTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            synopsisLabel.topAnchor.constraint(equalTo: synopsisTitleLabel.bottomAnchor, constant: 10),
            synopsisLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            synopsisLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            trailersTitleLabel.topAnchor.constraint(equalTo: synopsisLabel.bottomAnchor, constant: 20),
            trailersTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            trailersTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

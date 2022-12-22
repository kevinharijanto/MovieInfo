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
    
//    private lazy var gradientBox: UIView = {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let box = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 200))
//        box.translatesAutoresizingMaskIntoConstraints = false
//        box.backgroundColor = .red
//        box.clipsToBounds = true
//        return box
//    }()
    
    private lazy var gradientBox: UIView = {
        let screenSize: CGRect = UIScreen.main.bounds
        let box = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 200))
        box.translatesAutoresizingMaskIntoConstraints = false
        box.addGradientWithColor()
        return box
    }()
    
//    private lazy var gradient: CAGradientLayer = {
//        let gradient = CAGradientLayer()
//        gradient.type = .axial
//        gradient.colors = [UIColor.clear.withAlphaComponent(0.0).cgColor,
//                           UIColor.movieBlue.cgColor]
//        gradient.locations = [0,1]
//        gradient.frame = self.gradientBox.bounds
//        return gradient
//    }()
    
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
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(DetailsTrailerCell.self, forCellReuseIdentifier: DetailsTrailerCell.identifier)
        tv.backgroundColor = .clear
        
        tv.dataSource = self
        tv.delegate = self
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.movieBlue
        configureScrollView()
        configureUI()
        configureImage()
        configureTrailer()
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
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
    
    private func configureUI() {
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(gradientBox)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(genreLabel)
        
        let movieDurationAndRating = UIStackView(arrangedSubviews: [durationLabel, ratingLabel])
        movieDurationAndRating.axis = .horizontal
        movieDurationAndRating.translatesAutoresizingMaskIntoConstraints = false
        movieDurationAndRating.alignment = .center
        view.addSubview(movieDurationAndRating)
        
        contentView.addSubview(synopsisTitleLabel)
        contentView.addSubview(synopsisLabel)
        contentView.addSubview(trailersTitleLabel)
        contentView.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 2.25),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -50),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            gradientBox.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -150),
            
            movieDurationAndRating.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            movieDurationAndRating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            synopsisTitleLabel.topAnchor.constraint(equalTo: movieDurationAndRating.bottomAnchor, constant: 20),
            synopsisTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            synopsisLabel.topAnchor.constraint(equalTo: synopsisTitleLabel.bottomAnchor, constant: 10),
            synopsisLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            synopsisLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            trailersTitleLabel.topAnchor.constraint(equalTo: synopsisLabel.bottomAnchor, constant: 20),
            trailersTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            trailersTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -200),
        ])
    }
    
    private func configureImage() {
        ImageClient.shared.setImage(from: movie.backdropURL, image: nil) { [weak self] image in
            self?.movieImageView.image = image
        }
    }
    
    private func configureTrailer() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: trailersTitleLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 500),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
        ])
    }
    
    private func playInYoutube(url: String) {
        let appURL = NSURL(string: "youtube://\(url)")!
        let webURL = NSURL(string: "https://\(url)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
}

extension DetailsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.youtubeTrailers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTrailerCell.identifier) as! DetailsTrailerCell
//        cell.bindViewWith(movie: movie.youtubeTrailers![indexPath.row])
        cell.configureUI(movie: movie.youtubeTrailers![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.playInYoutube(url: movie.youtubeTrailers![indexPath.row].youtubeURL!.absoluteString)
    }
}

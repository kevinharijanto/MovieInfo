//
//  NowPlayingCell.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 03/12/22.
//

import Foundation
import UIKit

class NowPlayingCell: UITableViewCell {
    static let identifier = "NowPlayingCell"
    
    private var vm: MovieListViewModel?
    private var page = 1
//    private var movies: [Movie]!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Now Playing"
        label.textColor = .white
        return label
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 250)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCellNowPlaying")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private func spinnerLoading() -> UIView {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = container.center
        container.addSubview(spinner)
        spinner.startAnimating()
        return container
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .clear
        
        addSubview(titleLabel)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])
    }
}

extension NowPlayingCell {
    func bindViewWith(viewModel: MovieListViewModel) {
        let vm = viewModel
        self.vm = vm
        self.collectionView.reloadData()
    }
}

extension NowPlayingCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCellNowPlaying", for: indexPath) as! MovieCell
        
        // add movie object to cell here
        let movie = vm?.movies[indexPath.row]
//        cell.bindViewWith(viewModel: MovieViewModel(movie: movie!))
        cell.bindViewWith(movie: movie!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = (vm?.movies.count)! - 1
        if indexPath.row == lastElement {
            // Fetch new page
            print("fetching now \(page)")
            page += 1
            vm?.fetchMovies(page: page)
            vm?.onFetchMovieSucceed = { [weak self] in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}

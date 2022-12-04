//
//  MainView.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 23/11/22.
//

import UIKit

class MainView: UITableViewController {
    
    // MARK: - Properties
    private let nowPlayingViewModel: MovieListViewModel
    private let upcomingViewModel: MovieListViewModel
    private let topRatedViewModel: MovieListViewModel
    
    private let detailViewModel: MovieDetailViewModel
    
    // MARK: - Lifecycle
    
    init(nowPlayingViewModel: MovieListViewModel, upcomingViewModel: MovieListViewModel, topRatedViewModel: MovieListViewModel, detailViewModel: MovieDetailViewModel) {
        self.nowPlayingViewModel = nowPlayingViewModel
        self.upcomingViewModel = upcomingViewModel
        self.topRatedViewModel = topRatedViewModel
        
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .movieBlue
        configureTableView()
    }
    
    // Change status bar color to white
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureTableView() {
        tableView.register(NowPlayingCell.self, forCellReuseIdentifier: NowPlayingCell.identifier)
        tableView.register(UpcomingCell.self, forCellReuseIdentifier: UpcomingCell.identifier)
        tableView.register(TopRatedCell.self, forCellReuseIdentifier: TopRatedCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension MainView {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingCell.identifier, for: indexPath) as! NowPlayingCell
            
            // pass movie array
            nowPlayingViewModel.onFetchMovieSucceed = {
                cell.bindViewWith(viewModel: self.nowPlayingViewModel)
            }
            cell.delegate = self
            
            return cell
        }
        
        if indexPath.section < 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingCell.identifier, for: indexPath) as! UpcomingCell
            
            // pass movie array
            upcomingViewModel.onFetchMovieSucceed = {
                cell.bindViewWith(viewModel: self.upcomingViewModel)
            }
            cell.delegate = self
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedCell.identifier, for: indexPath) as! TopRatedCell

        // pass movie array
        topRatedViewModel.onFetchMovieSucceed = {
            cell.bindViewWith(viewModel: self.topRatedViewModel)
        }
        cell.delegate = self

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
}

protocol MainViewDelegate: AnyObject {
    func navigate(id: Int)
}

extension MainView: MainViewDelegate {
    func navigate(id: Int) {
        
        detailViewModel.fetchMovie(id: id)
        detailViewModel.onFetchMovieSucceed = {
            let vc = DetailsView(movie: self.detailViewModel.movie)
            self.show(vc, sender: self)
        }
    }
}

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
    
    // MARK: - Lifecycle
    
    init(nowPlayingViewModel: MovieListViewModel, upcomingViewModel: MovieListViewModel) {
        self.nowPlayingViewModel = nowPlayingViewModel
        self.upcomingViewModel = upcomingViewModel
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
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureTableView() {
        tableView.register(NowPlayingCell.self, forCellReuseIdentifier: NowPlayingCell.identifier)
        tableView.register(UpcomingCell.self, forCellReuseIdentifier: UpcomingCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section <= 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingCell.identifier, for: indexPath) as! NowPlayingCell
            
            // pass movie array
            nowPlayingViewModel.onFetchMovieSucceed = {
                cell.bindViewWith(viewModel: self.nowPlayingViewModel)
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingCell.identifier, for: indexPath) as! UpcomingCell
        // pass movie array
        upcomingViewModel.onFetchMovieSucceed = {
            cell.bindViewWith(viewModel: self.upcomingViewModel)
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    
}

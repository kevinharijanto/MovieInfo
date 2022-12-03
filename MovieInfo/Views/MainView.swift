//
//  MainView.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 23/11/22.
//

import UIKit

class MainView: UITableViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
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
        if indexPath.section <= 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingCell.identifier, for: indexPath) as! NowPlayingCell
            return cell
        }
        
        if indexPath.section <= 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingCell.identifier, for: indexPath) as! UpcomingCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingCell.identifier, for: indexPath) as! NowPlayingCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    
}

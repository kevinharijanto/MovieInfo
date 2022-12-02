//
//  MainView.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 23/11/22.
//

import UIKit

class MainView: UIViewController {
    
    // MARK: - Properties
    let vm = MovieViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        // bikin UI Main Page
        vm.fetchMovie()
//        vm.fetchAllMovies()
    }
}

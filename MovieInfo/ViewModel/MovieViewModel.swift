//
//  MovieViewModel.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 02/12/22.
//

import Foundation

struct MovieViewModel {
    
    func fetchMovie() {
        Service.shared.fetchMovie(id: 724495) { result in
            switch result {
            case .success(let response):
                print(response.genreText)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchAllMovies() {
        Service.shared.fetchMovies(from: .nowPlaying) { result in
            switch result {
            case .success(let response):
                print(response.results[0])
            case .failure(let error):
                print(error)
            }
        }
    }
}

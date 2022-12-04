//
//  NowPlayingViewModel.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 04/12/22.
//

import Foundation

final class NowPlayingViewModel: MovieListViewModel {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        fetchMovies(page: 1)
    }
    
    var movies: [Movie] = []
    var onFetchMovieSucceed: (() -> Void)?
    var onFetchMovieFailure: ((Error) -> Void)?
    
    func fetchMovies(page: Int) {
        let request = MoviesRequest(page: page, endPoint: .nowPlaying)
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies.append(contentsOf: movies)
                self?.onFetchMovieSucceed?()
                
            case .failure(let error):
                self?.onFetchMovieFailure?(error)
            }
        }
    }
}

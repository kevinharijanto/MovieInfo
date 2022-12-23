//
//  MovieDetailViewModel.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 04/12/22.
//

import Foundation

protocol MovieDetailViewModel: AnyObject {
    var movie: Movie { get set }
    var onFetchMovieSucceed: (() -> Void)? { get set }
    var onFetchMovieFailure: ((Error) -> Void)? { get set }
    func fetchMovie(id: Int)
}

final class MovieDetailDefaultViewModel: MovieDetailViewModel {
    
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    var movie: Movie = Movie.data[0]
    var onFetchMovieSucceed: (() -> Void)?
    var onFetchMovieFailure: ((Error) -> Void)?

    func fetchMovie(id: Int) {
        let request = MovieRequest(id: id)
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.movie = movie
                self?.onFetchMovieSucceed?()

            case .failure(let error):
                self?.onFetchMovieFailure?(error)
            }
        }
    }
}

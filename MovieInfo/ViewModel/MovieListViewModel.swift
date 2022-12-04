//
//  MovieListViewModel.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 04/12/22.
//

import Foundation

protocol MovieListViewModel: AnyObject {
    var movies: [Movie] { get set }
    var onFetchMovieSucceed: (() -> Void)? { get set }
    var onFetchMovieFailure: ((Error) -> Void)? { get set }
    func fetchMovies(page: Int)
}

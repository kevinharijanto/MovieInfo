//
//  MoviesResource.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 23/12/22.
//

import Foundation

struct MoviesResource: APIResource {
    typealias ModelType = Movie
    var id: Int
    
    var methodPath: String {
        return "/3/movie/\(id)"
    }
    
    var params: String?
}

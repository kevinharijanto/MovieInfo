//
//  NowPlayingMovieRequest.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 03/12/22.
//

import Foundation

struct MoviesRequest: DataRequest {
    
    var page: Int
    var endPoint: MovieEndPoint
    
    private let apiKey: String = "87fc07fe65dbd028b34a61c4b99d63af"

    var url: String {
        let baseURL: String = "https://api.themoviedb.org/3"
        let path: String = "/movie/\(endPoint.rawValue)"
        return baseURL + path
    }
    
    var params: [String : String]? {
        [:]
    }
    
    var queryItems: [String : String] {
        [
            "api_key": apiKey,
            "page": "\(page)"
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [Movie] {
        let response = try Utils.jsonDecoder.decode(MoviesResponse.self, from: data)
        return response.results
    }
}

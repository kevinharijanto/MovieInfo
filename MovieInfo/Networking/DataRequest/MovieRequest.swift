//
//  MovieRequest.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 03/12/22.
//

import Foundation

struct MovieRequest: DataRequest {
    
    var id: Int
    
    private let apiKey: String = "87fc07fe65dbd028b34a61c4b99d63af"

    var url: String {
        let baseURL: String = "https://api.themoviedb.org/3"
        let path: String = "/movie/\(id)"
        return baseURL + path
    }
    
    var params: [String : String]? {
        ["append_to_response": "videos"]
    }
    
    var queryItems: [String : String] {
        [
            "api_key": apiKey
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> Movie {
        let response = try Utils.jsonDecoder.decode(Movie.self, from: data)
        return response
    }
}

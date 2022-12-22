//
//  NetworkManager.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 09/12/22.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var params: String? { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "https://api.themoviedb.org/")!
        let apiKey = "87fc07fe65dbd028b34a61c4b99d63af"
        components.path = methodPath
        components.queryItems = [
        URLQueryItem(name: "api_key", value: apiKey),
//        URLQueryItem(name: "page", value: "1"),
        ]
        if let params = params {
            components.queryItems?.append(URLQueryItem(name: "append_to_response", value: params))
        }
        return components.url!
    }
}

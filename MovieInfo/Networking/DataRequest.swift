//
//  DataRequest.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 03/12/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol DataRequest {
    associatedtype Response
    
    var url: String { get }
    var method: HTTPMethod { get }
    var queryItems: [String: String] { get }
    var params: [String: String]? { get }
    
    func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        return try Utils.jsonDecoder.decode(Response.self, from: data)
    }
}

extension DataRequest {
    var queryItems: [String: String] {
        [:]
    }
    
    var params: [String: String]? {
        [:]
    }
}

//
//  APIRequest.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 09/12/22.
//

import Foundation

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    
    func execute(withCompletion completion: @escaping (Result<Resource.ModelType?, MovieError>) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}

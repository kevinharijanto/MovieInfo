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
    // FUNGSI INI GA JALAN
    func decode(_ data: Data) -> Resource.ModelType? {
        print("A")
        return try? Utils.jsonDecoder.decode(Resource.ModelType.self, from: data)
    }
    
    func execute(withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}

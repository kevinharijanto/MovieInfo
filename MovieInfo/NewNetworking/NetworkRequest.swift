//
//  NetworkRequest.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 23/12/22.
//

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType: Decodable
    func execute(withCompletion completion: @escaping (Result<ModelType?, MovieError>) -> Void)
}

extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (Result<ModelType?, MovieError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response , error) -> Void in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.apiError))
                }
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            do {
                let decodedResponse = try Utils.jsonDecoder.decode(ModelType.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

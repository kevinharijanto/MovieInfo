//
//  NetworkRequest.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 23/12/22.
//

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
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
            
//            do {
//                let data2 = try JSONDecoder().decode(Movie.self, from: data)
//                print(data2)
//            } catch {
//                print(error.localizedDescription)
//            }
            
            let decodedResponse = self?.decode(data)
            DispatchQueue.main.async {
                completion(.success(decodedResponse))
            }
        }
        task.resume()
    }
}

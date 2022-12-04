//
//  NetworkService.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 03/12/22.
//

import Foundation
import RxSwift

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, MovieError>) -> Void)
}

final class DefaultNetworkService: NetworkService {
    
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, MovieError>) -> Void) {
        
        guard var urlComponent = URLComponents(string: request.url) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems: [URLQueryItem] = []
        
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        request.params?.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let finalURL = urlComponent.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = request.method.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
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
                let decodedResponse = try request.decode(data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.serializationError))
                }
            }
        }
        .resume()
    }
}

//final class RxNetworkService {
//    
//    let bag = DisposeBag()
//    
//    func request<Request: DataRequest>(_ request: Request) -> Observable<MoviesResponse> {
//        
//        var urlComponent = URLComponents(string: request.url)!
//        
//        var queryItems: [URLQueryItem] = []
//        
//        request.queryItems.forEach {
//            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
//            urlComponent.queryItems?.append(urlQueryItem)
//            queryItems.append(urlQueryItem)
//        }
//        
//        request.params?.forEach {
//            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
//            queryItems.append(urlQueryItem)
//        }
//        
//        urlComponent.queryItems = queryItems
//        
//        let finalURL = urlComponent.url!
//        
//        var urlRequest = URLRequest(url: finalURL)
//        urlRequest.httpMethod = request.method.rawValue
//        
//        return URLSession.shared.rx.response(request: urlRequest)
//            .map { result -> Data in
//                guard result.response.statusCode == 200 else {
//                    throw MovieError.invalidResponse
//                }
//                return result.data
//            }.map { data in
//                do {
//                    let movies = try Utils.jsonDecoder.decode(MoviesResponse.self, from: data)
//                    
//                    return movies
//                } catch let error {
//                    throw MovieError.invalidEndpoint
//                }
//            }
//            .observe(on: MainScheduler.instance)
//            .asObservable()
//    }
//}

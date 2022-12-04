//
//  ImageService.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 04/12/22.
//

import Foundation
import UIKit

protocol ImageService {
    func downloadImage<Request: DataRequest>(request: Request, completion: @escaping (UIImage?, MovieError?)-> Void)
    func setImage(from url: String, image: UIImage?, completion: @escaping (UIImage?)-> Void)
}

final class ImageClient {
    static let shared = ImageClient()
    
    private(set) var cachedImageForURL: [String: UIImage]
    private(set) var cachedTaskForImageView: [UIImageView : NetworkService]
    
    init() {
        self.cachedImageForURL = [:]
        self.cachedTaskForImageView = [:]
    }
    
    private func dispatchImageInMainThread(image: UIImage? = nil, error: MovieError? = nil, completion: @escaping (UIImage?, MovieError?)-> Void) {
        DispatchQueue.main.async {
            completion(image, error)
        }
    }
}

extension ImageClient: ImageService {
    func downloadImage<Request>(request: Request, completion: @escaping (UIImage?, MovieError?) -> Void) where Request : DataRequest {
        
        let service: NetworkService = DefaultNetworkService()
        
        service.request(request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                guard let image: UIImage = response as? UIImage else { return }
                self.dispatchImageInMainThread(image: image, completion: completion)
            case .failure(let error):
                self.dispatchImageInMainThread(error: error, completion: completion)
            }
        }
    }
    
    func setImage(from url: String, image: UIImage?, completion: @escaping (UIImage?) -> Void) {
        
        let request = ImageRequest(url: url)
        if let cachedImage = cachedImageForURL[url] {
            completion(cachedImage)
        } else {
            downloadImage(request: request) { [weak self] image, error in
                guard let self = self else { return }
                
                guard let image = image else {
                    print(error?.localizedDescription as Any)
                    return
                }
                
                self.cachedImageForURL[url] = image
                completion(self.cachedImageForURL[url])
            }
        }
    }
    
    
}

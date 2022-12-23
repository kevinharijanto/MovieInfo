//
//  ViewModel.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 09/12/22.
//

import Foundation

struct ViewModel {
    
    func fetchTopQuestions() {
        let resource = MoviesResource(id: 1990)
        let request = APIRequest(resource: resource)
        
        request.execute { result in
            switch result {
            case .success(let movie):
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

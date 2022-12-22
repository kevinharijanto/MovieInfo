//
//  ViewModel.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 09/12/22.
//

import Foundation

struct ViewModel {
    
    func fetchTopQuestions() {
        let resource = MoviesResource(id: 500)
        let request = APIRequest(resource: resource)
        
//        let url = resource.url
//        let task = URLSession.shared.dataTask(with: url) { (data, _, _) -> Void in
//            guard let data = data else {
//                return
//            }
//            let wrapper = try? Utils.jsonDecoder.decode(Movie.self, from: data)
//            print(wrapper)
//        }
//        task.resume()
        
        
        request.execute { movie in
            print(movie ?? "")
        }
        
        print("Beres")
    }
    
}

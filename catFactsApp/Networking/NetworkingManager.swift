//
//  NetworkingManager.swift
//  catFactsApp
//
//  Created by Ivan Obodovskyi on 14.10.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import Foundation

protocol Router {
    var baseURL: String { get }
    var urlPath: String { get }
}

enum NetworkRouter: Router {
    case facts
    
    var baseURL: String {
        switch self {
        case .facts:
            return "cat-fact.herokuapp.com"
        }
    }
    
    var urlPath: String {
        switch self {
        case .facts:
            return "/facts"
        }
    }
}


final class NetworkingService {
    
    public static var shared = NetworkingService()
    
    private init() { } 
    
    public func fetchData(with router: NetworkRouter, completionHandler: @escaping (CatsResponse?, URLResponse?, Error?) -> Void) {
        
        guard let url = self.buildURL(router: router) else {
            print("Ooops, invalid url!")
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, urlResponse, error in
            if error != nil && urlResponse != nil {
                completionHandler(nil, urlResponse, error)
            }
            
            if let catsData = data {
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(CatsResponse.self, from: catsData)
                    completionHandler(data, urlResponse, nil)
                } catch let serializationError {
                    print(serializationError.localizedDescription)
                }
            }
        }.resume()
    }
}

extension NetworkingService {
    private func buildURL(router: NetworkRouter) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = router.baseURL
        urlComponents.path = router.urlPath
        
        return urlComponents.url
    }
}

//
//  NetworkRouter.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 05/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation


class NetworkRouter {
    private var task: URLSessionTask?
    public static let shared = NetworkRouter()
    
    private init(){}
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                DispatchQueue.main.async {
                    completion(data, response, error)
                }
            })
            
        } catch {
            DispatchQueue.main.async {
                completion(nil, nil, error)
            }
        }
        
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 5.0)
        
        request.httpMethod = route.httpMethod.rawValue
        request.setValue(NetworkConstants.contentTypeValue, forHTTPHeaderField: NetworkConstants.contentTypeKey)
        URLParameterEncoder.encode(urlRequest: &request, with: route.params)
        
        return request
    }
}

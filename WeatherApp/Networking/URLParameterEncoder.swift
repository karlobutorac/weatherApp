//
//  URLParameterEncoder.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 05/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation


public struct URLParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameteres: Parameters)  {
    
        guard let url = urlRequest.url else {
            return
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameteres.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in parameteres {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
 
            urlRequest.url = urlComponents.url
        }
    }
}

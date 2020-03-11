//
//  EndPoint.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 05/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation

protocol EndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var params: Parameters { get }
}

public enum WeatherAPI {
    case detailsFromSingle(id: Int)
    case detailsFromMultiple(ids: [Int])
}

extension WeatherAPI: EndPoint {
    var baseURL: URL {
        return URL(string: NetworkConstants.weatherAPIUrl)!
    }
    
    var path: String {
        return NetworkConstants.weatherAPIPath
    }
    
    var httpMethod: HTTPMethod {
        return HTTPMethod.get
    }
    
    var params: Parameters {
        var params = Parameters()
        
        params[NetworkConstants.authenticationParamKey] = NetworkConstants.authenticationParamValue
        params[NetworkConstants.unitsParamKey] = NetworkConstants.unitsParamValue

        switch self {
        case .detailsFromSingle(let id):
            params[NetworkConstants.cityIdParamKey] = "\(id)"
        case .detailsFromMultiple(let ids):
            params[NetworkConstants.cityIdParamKey] = "\(ids)".replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "") // from "[0, 1, 2, 3]" to "0,1,2,3"
        }
        
        return params
    }
}

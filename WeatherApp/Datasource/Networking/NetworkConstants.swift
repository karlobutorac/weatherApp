//
//  NetworkConstants.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 05/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation


public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()
public typealias HTTPHeaders = [String:String]
public typealias Parameters = [String:String]

enum ForecastNetworkResult<T> {
    case success(result: T)
    case failure(String)
}

struct NetworkConstants {
    public static let authenticationParamKey = "APPID"
    public static let authenticationParamValue = "1604c2075a5c4e14532ade8775983ed9"
    public static let unitsParamKey = "units"
    public static let unitsParamValue = "metric"
    public static let cityIdParamKey = "id"
    public static let weatherAPIUrl = "http://api.openweathermap.org"
    public static let weatherAPIPath = "data/2.5/group"
    public static let contentTypeKey = "Content-Type"
    public static let contentTypeValue = "Application/json"
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

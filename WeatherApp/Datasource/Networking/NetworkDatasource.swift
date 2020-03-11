//
//  NetworkDatasource.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 05/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit


class NetworkDatasource {
    public static let shared = NetworkDatasource()
    
    private init() {
        // Singleton
    }
    
    func getWeatherDetails(for ids: [Int], completion: @escaping (ForecastNetworkResult<[JSONForecast]>) -> Void) {
        NetworkRouter.shared.request(WeatherAPI.detailsFromMultiple(ids: ids)) { (data, response, error) in
            
            if let errorResponse = self.handleErrorNetworkResponse(data, response, error) {
                completion(errorResponse)
                return
            }
            
            do {
                let networkResponse = try JSONDecoder().decode(NetworkResponse.self, from: data!)
                completion(ForecastNetworkResult.success(result: networkResponse.list))
                
            } catch let error {
                completion(ForecastNetworkResult.failure(error.localizedDescription))
            }
        }
    }
    
    private func handleErrorNetworkResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ForecastNetworkResult<[JSONForecast]>? {
        if let error = error {
            return .failure(error.localizedDescription)
        }
        
        guard let response = response as? HTTPURLResponse else {
            return .failure("Response is not of type HTTPURLResponse")
        }
        
        guard let _ = data else {
            return .failure("No data")
        }
        
        switch response.statusCode {
        case 200...299: return nil
        case 300...399: return .failure("Redirection failure, with status code: \(response.statusCode)")
        case 400...499: return .failure("Client failure, with status code: \(response.statusCode)")
        default: return .failure("Network failure, with status code: \(response.statusCode)")}
    }
}

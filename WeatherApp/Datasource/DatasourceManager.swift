//
//  DatasourceManager.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 05/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation


class DatasourceManager: Datasource {
    public static let shared = DatasourceManager()
    
    private init() {}
    
    func getAllMyForecastsIds() -> [Int]  {
        return CoreDataDatasource.shared.getAllMyForecastsIds()
    }
    
    func getMyForecastsCount() -> Int {
        return CoreDataDatasource.shared.getMyForecastsCount()
    }
    
    func getWeatherForecasts(for ids: [Int], completion: @escaping (DatabaseQueryResult<[Forecast]>) -> Void) {
        NetworkDatasource.shared.getWeatherDetails(for: ids) { forecastNetworkResult in
            switch forecastNetworkResult {
            case .success(let jsonForecasts):
                
                CoreDataDatasource.shared.saveForecasts(forecasts: Forecast.createArray(from: jsonForecasts))
                completion(DatabaseQueryResult<[Forecast]>.success(result: Forecast.createArray(from: jsonForecasts)))
                
            case .failure(let error):
                let coreDataResult = CoreDataDatasource.shared.getAllForecasts()
                
                if case .success(let coreDataForecasts) = coreDataResult, coreDataForecasts.count != 0 {
                    completion(DatabaseQueryResult.success(result: Forecast.createArray(from: coreDataForecasts)))
                    return
                } else {
                    completion(DatabaseQueryResult.failure(error: error))
                }
            }
        }
    }
    
    func getAllWeatherForecasts(completion: @escaping (DatabaseQueryResult<[Forecast]>) -> Void) {
        NetworkDatasource.shared.getWeatherDetails(for: getAllMyForecastsIds()) { forecastNetworkResult in
            switch forecastNetworkResult {
            case .success(let jsonForecasts):
                
                CoreDataDatasource.shared.saveForecasts(forecasts: Forecast.createArray(from: jsonForecasts))
                completion(DatabaseQueryResult<[Forecast]>.success(result: Forecast.createArray(from: jsonForecasts)))
                
            case .failure(let error):
                let coreDataResult = CoreDataDatasource.shared.getAllForecasts()
                
                if case .success(let coreDataForecasts) = coreDataResult, coreDataForecasts.count != 0 {
                    completion(DatabaseQueryResult.success(result: Forecast.createArray(from: coreDataForecasts)))
                    return
                } else {
                    completion(DatabaseQueryResult.failure(error: error))
                }
            }
        }
    }
}

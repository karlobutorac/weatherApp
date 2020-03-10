//
//  Datasource.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 05/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation

public enum DatabaseQueryResult<T> {
    case success(result: T)
    case failure(error: String)
}

protocol Datasource {
    func getAllMyForecastsIds() -> [Int]
    func getMyForecastsCount() -> Int
    func getAllWeatherForecasts(completion: @escaping (DatabaseQueryResult<[Forecast]>) -> Void)
    func getWeatherForecasts(for ids: [Int], completion: @escaping (DatabaseQueryResult<[Forecast]>) -> Void)
}

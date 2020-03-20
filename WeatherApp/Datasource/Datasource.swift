//
//  Datasource.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 05/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public enum DatabaseQueryResult<T> {
    case success(result: T)
    case failure(error: String)
}

protocol Datasource {
    func getAllWeatherForecastsObservable() -> Driver<DatabaseQueryResult<[Forecast]>>
    func pullAllLatestWeatherForecasts()
    func getWeatherForecastObservable(for id: Int) -> Driver<DatabaseQueryResult<Forecast>>
    func pullLatestWeatherForecast(for id: Int)
}

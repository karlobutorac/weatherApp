//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 16/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class WeatherForecastViewModel {
    private let disposeBag = DisposeBag()
    private let datasource: Datasource
    private let cityId: Int

    
    init (datasource: Datasource, cityId: Int, forecast: Forecast) {
        self.datasource = datasource
        self.cityId = cityId
        self.forecast = BehaviorRelay<Forecast>(value: forecast)
        
        self.name = BehaviorSubject<String>.init(value: forecast.name)
        self.currentTemp = BehaviorSubject<String>.init(value: "\(forecast.currentTemp)°")
        self.minTemp = BehaviorSubject<String>.init(value: "\(forecast.minTemp)°")
        self.maxTemp = BehaviorSubject<String>.init(value: "\(forecast.maxTemp)°")
    }
    

    var forecast: BehaviorRelay<Forecast>
    var name: BehaviorSubject<String>
    var currentTemp: BehaviorSubject<String>
    var minTemp: BehaviorSubject<String>
    var maxTemp: BehaviorSubject<String>
    
    var colorScheme: BehaviorSubject<[CGColor]> {
        return BehaviorSubject.init(value: UIColor.getColorScheme(for: cityId))
    }
    
    
    func update() {
        datasource.getWeatherForecast(for: cityId) { databaseQueryResult in
            switch databaseQueryResult {
            case .success(let result):
                self.name.onNext(result.name)
                self.currentTemp.onNext("\(result.currentTemp)°")
                self.minTemp.onNext("\(result.minTemp)°")
                self.maxTemp.onNext("\(result.maxTemp)°")
            case .failure(let error):
                print(error)
            }
        }
    }
}

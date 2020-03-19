//
//  ForecastListViewModel.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 16/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ForecastListViewModel {
    private let datasource: Datasource
    
    private let _forecasts = BehaviorRelay<[Forecast]>(value: [])
    
    init(datasource: Datasource) {
        self.datasource = datasource
        self.fetchForecasts()
    }
    
    var forecasts: Driver<[Forecast]> {
        return _forecasts.asDriver()
    }
    
    var numberOfForecasts: Int {
        return _forecasts.value.count
    }
    
    func forecastViewModelForForecast(at index: Int) -> ForecastCellViewModel? {
        guard index < _forecasts.value.count else {
            return nil
        }
        
        return ForecastCellViewModel(forecast: _forecasts.value[index])
    }
    
    func modelForForecast(at index: Int) -> Forecast? {
        guard index < _forecasts.value.count else {
            return nil
        }
        
        return _forecasts.value[index]
    }
    
    func fetchForecasts() {
        self._forecasts.accept([])
        
        datasource.getAllWeatherForecasts { datasouceQueryResult in
            switch datasouceQueryResult {
            case .success(let result):
                self._forecasts.accept(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}

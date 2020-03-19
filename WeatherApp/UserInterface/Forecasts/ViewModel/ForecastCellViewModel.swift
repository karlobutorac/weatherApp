//
//  ForecastCellViewModel.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 16/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


class ForecastCellViewModel {
    private let forecast: Forecast
    
    init (forecast: Forecast) {
        self.forecast = forecast
    }

    var name: String {
        return forecast.name
    }
    
    var currentTemp: String {
        return "\(forecast.currentTemp)°"
    }
    
    var minTemp: String {
        return "\(forecast.minTemp)°"
    }
    
    var maxTemp: String {
        return "\(forecast.maxTemp)°"
    }
    
    var colorScheme: [CGColor]? {
        return forecast.colorScheme
    }
}

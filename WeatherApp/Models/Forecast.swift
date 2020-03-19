//
//  PlaceModel.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 03/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit

public struct Forecast {
    var colorScheme: [CGColor]?
    var name: String
    var currentTemp: Int
    var maxTemp: Int
    var minTemp: Int
    var id: Int
    var feelsLike: Int
    var wind: Int
    var humidity: Int
    var pressure: Int
    var visibility: Int
    
    internal static func createArray(from jsonForecasts: [JSONForecast]) -> [Forecast]{
        var list = [Forecast]()
        
        for json in jsonForecasts {
            list.append(Forecast(jsonForecast: json))
        }
        
        return list
    }
    
    internal static func createArray(from coreDataForecasts: [ForecastCD]) -> [Forecast]{
        var list = [Forecast]()
        
        for coreDataForecast in coreDataForecasts {
            list.append(Forecast(coreDataForecast: coreDataForecast))
        }
        
        return list
    }
    
    func getDetails() -> [Details] {
        var details = [Details]()
        
        details.append(Details.feelsLike(feelsLike))
        details.append(Details.wind(wind))
        details.append(Details.humidity(humidity))
        details.append(Details.pressure(pressure))
        details.append(Details.visibility(visibility))
        
        return details
    }
    
    init (cityId: Int) {
        self.name = ""
        self.currentTemp = 0
        self.maxTemp = 0
        self.minTemp = 0
        self.id = cityId
        self.colorScheme = UIColor.getColorScheme(for: id)
        self.feelsLike = 0
        self.wind = 0
        self.humidity = 0
        self.pressure = 0
        self.visibility = 0
    }
    
    init (jsonForecast: JSONForecast) {
        self.name = jsonForecast.name
        self.currentTemp = Int(jsonForecast.main.currentTemp)
        self.maxTemp = Int(jsonForecast.main.maxTemp)
        self.minTemp = Int(jsonForecast.main.minTemp)
        self.id = jsonForecast.id
        self.colorScheme = UIColor.getColorScheme(for: id)
        self.feelsLike = Int(jsonForecast.main.feelsLike)
        self.wind = Int(jsonForecast.wind.speed)
        self.humidity = jsonForecast.main.humidity
        self.pressure = jsonForecast.main.pressure
        self.visibility = jsonForecast.visibility
    }
    
    init (coreDataForecast: ForecastCD) {
        self.name = coreDataForecast.name
        self.id = coreDataForecast.id
        self.currentTemp = coreDataForecast.currentTemp
        self.maxTemp = coreDataForecast.maxTemp
        self.minTemp = coreDataForecast.minTemp
        self.colorScheme = UIColor.getColorScheme(for: coreDataForecast.id)
        self.feelsLike = coreDataForecast.feelsLike
        self.wind = coreDataForecast.wind
        self.humidity = coreDataForecast.humidity
        self.pressure = coreDataForecast.pressure
        self.visibility = coreDataForecast.visibility

    }
}

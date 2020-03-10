//
//  NetworkResponse.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 04/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation


struct NetworkResponse: Codable {
    var cnt: Int
    var list: [JSONForecast]
}

struct JSONForecast: Codable {
    var coord: Coordinates
    var sys: Sys
    var weather: [Weather]
    var main: Summery
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var id: Int
    var name: String
}

struct Summery: Codable {
    var currentTemp: Double
    var feelsLike: Double
    var minTemp: Double
    var maxTemp: Double
    var pressure: Int
    var humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case currentTemp = "temp"
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure
        case humidity
    }
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Clouds: Codable {
    var all: Int
}

struct Wind: Codable {
    var speed: Double
//    var deg: Int
}

struct Sys: Codable {
    var country: String
    var timezone: Int
    var sunrise: Int
    var sunset: Int
}

struct Coordinates: Codable {
    var lat: Double
    var lon: Double
}

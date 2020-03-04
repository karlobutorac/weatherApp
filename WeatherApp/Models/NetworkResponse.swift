//
//  NetworkResponse.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 04/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation


struct NetworkResponse: Codable {
    var cod: String
    var message: Int
    var cnt: Int
    var list: [Forecast]
    var city: City
}

struct Forecast: Codable {
    var dt: Int
    var main: Summery
    var weather: [Weather]
    var clouds: Clouds
    var wind: Wind
    var sys: Sys
    var dt_txt: String
}

struct Summery: Codable {
    var currentTemp: Double
    var feelsLike: Double
    var minTemp: Double
    var maxTemp: Double
    var pressure: Int
    var seaLevel: Int
    var groundLevel: Int
    var humidity: Int
    var tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case currentTemp = "temp"
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
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
    var deg: Int
}

struct Sys: Codable {
    var pod: String
}

struct City: Codable {
    var id: Int
    var name: String
    var coord: Coordinates
    var country: String
    var timezone: Int
    var sunrise: Int
    var sunset: Int
}

struct Coordinates: Codable {
    var lat: Double
    var lon: Double
}

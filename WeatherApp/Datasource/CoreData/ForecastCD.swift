//
//  ForecastCD.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 09/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import CoreData

public class ForecastCD: NSManagedObject, Identifiable {
    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var currentTemp: Int
    @NSManaged public var minTemp: Int
    @NSManaged public var maxTemp: Int
    @NSManaged public var id: Int
    
    @NSManaged public var feelsLike: Int
    @NSManaged public var wind: Int
    @NSManaged public var humidity: Int
    @NSManaged public var pressure: Int
    @NSManaged public var visibility: Int
}

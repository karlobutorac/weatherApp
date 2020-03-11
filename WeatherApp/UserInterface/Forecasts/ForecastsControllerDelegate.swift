//
//  ForecastsControllerDelegate.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation


public protocol ForecastsControllerDelegate: class {
    func didSelect(model: Forecast)
}

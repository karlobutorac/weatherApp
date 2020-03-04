//
//  PlacesControllerDelegate.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation


public protocol PlacesControllerDelegate: class {
    func didSelect(model: PlaceModel)
}

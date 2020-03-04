//
//  PlacesCoordinator.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit


class PlacesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let placesController: PlacesController = PlacesController()
        placesController.delegate = self
            
        self.navigationController.viewControllers = [placesController]
    }
}


extension PlacesCoordinator: PlacesControllerDelegate {
    
    func didSelect(model: PlaceModel) {
        let weatherCoordinator = WeatherCoordinator(navigationController: navigationController)
        weatherCoordinator.delegate = self
        weatherCoordinator.model = model
        childCoordinators.append(weatherCoordinator)
        weatherCoordinator.start()
    }
}

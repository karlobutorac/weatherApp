//
//  ForecastsCoordinator.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit


class ForecastsCoordinator: Coordinator {
    var datasource: Datasource
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController, datasource: Datasource) {
        self.navigationController = navigationController
        self.datasource = datasource
    }
    
    func start() {
        let forecastListController: ForecastListController = ForecastListController(datasource: datasource)
        forecastListController.delegate = self
            
        self.navigationController.viewControllers = [forecastListController]
    }
}


extension ForecastsCoordinator: ForecastListControllerDelegate {
    func didSelect(model: Forecast) {
        let weatherCoordinator = WeatherCoordinator(navigationController: navigationController, datasource: datasource)
        weatherCoordinator.delegate = self
        weatherCoordinator.model = model
        childCoordinators.append(weatherCoordinator)
        weatherCoordinator.start()
    }
}

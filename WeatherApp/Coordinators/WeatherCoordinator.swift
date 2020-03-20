//
//  WeatherCoordinator.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit


class WeatherCoordinator: Coordinator {
    var datasource: Datasource
    var childCoordinators: [Coordinator] = []
    var model: Forecast!
    weak var delegate: ForecastListControllerDelegate?

    weak var navigationController: UINavigationController!

    
    required init(navigationController: UINavigationController, datasource: Datasource) {
        self.navigationController = navigationController
        self.datasource = datasource
    }
    
    func start() {
        let weatherForecastController: WeatherForecastController =
            WeatherForecastController(datasource: datasource, cityId: model.id, forecast: model)
          
        weatherForecastController.delegate = self
        weatherForecastController.modalPresentationStyle = .overFullScreen

        self.navigationController.present(weatherForecastController, animated: false, completion: nil)
    } 
}

extension WeatherCoordinator: WeatherForecastControllerDelegate {
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

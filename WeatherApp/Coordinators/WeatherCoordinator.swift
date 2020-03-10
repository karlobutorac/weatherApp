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
    weak var delegate: ForecastsControllerDelegate?

    unowned let navigationController: UINavigationController

    
    required init(navigationController: UINavigationController, datasource: Datasource) {
        self.navigationController = navigationController
        self.datasource = datasource
    }
    
    func start() {
        let weatherController: WeatherController = WeatherController(model: model)
        weatherController.delegate = self
        weatherController.modalPresentationStyle = .overFullScreen
        
        self.navigationController.present(weatherController, animated: false, completion: nil)
    } 
}

extension WeatherCoordinator: WeatherControllerDelegate {
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

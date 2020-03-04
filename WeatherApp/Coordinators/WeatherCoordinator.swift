//
//  WeatherCoordinator.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit


class WeatherCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var model: PlaceModel!
    weak var delegate: PlacesControllerDelegate?

    unowned let navigationController: UINavigationController
    
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let weatherController: WeatherController = WeatherController(model: model)
        weatherController.delegate = self
        weatherController.modalPresentationStyle = .overFullScreen
//        weatherController.transitioningDelegate = transitionDelegate
        
        self.navigationController.present(weatherController, animated: true, completion: nil)
    }
    

    
}

extension WeatherCoordinator: WeatherControllerDelegate {
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var datasource: Datasource { get set }
    
    init(navigationController: UINavigationController, datasource: Datasource)
    
    func start()
}

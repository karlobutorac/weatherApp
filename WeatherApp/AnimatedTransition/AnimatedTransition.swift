//
//  AnimatedTransition.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 11/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit

protocol AnimatedTransition {
    func animateTransition(for indexPath: IndexPath, completion: @escaping (Bool) -> Void)
}

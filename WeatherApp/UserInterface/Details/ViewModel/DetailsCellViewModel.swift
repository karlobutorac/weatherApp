//
//  DetailsCellViewModel.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 17/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class DetailsCellViewModel {
    private let details: Details
    
    init(details: Details) {
        self.details = details
    }
    
    var title: String {
        switch  details {
        case .feelsLike(_):
            return "Feels like"
        case .humidity(_):
            return "Humidity"
        case .pressure(_):
            return "Pressure"
        case .visibility(_):
            return "Visibility"
        case .wind(_):
            return "Wind"
        }
    }
    
    var value: String {
        switch  details {
        case .feelsLike(let value):
            return "\(value)°"
        case .humidity(let value):
            return "\(value)%"
        case .pressure(let value):
            return "\(value)"
        case .visibility(let value):
            return "\(value)"
        case .wind(let value):
            return "\(value)km/h"
        }
    }
    
    var image: UIImage {
        switch  details {
        case .feelsLike(_):
            return UIImage.init(named: AssetHelper.tempImageName)?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        case .humidity(_):
            return UIImage.init(named: AssetHelper.humidityImageName)?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        case .pressure(_):
            return UIImage.init(named: AssetHelper.pressureImageName)?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        case .visibility(_):
            return UIImage.init(named: AssetHelper.visibilityImageName)?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        case .wind(_):
            return UIImage.init(named: AssetHelper.windImageName)?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        }
    }
}

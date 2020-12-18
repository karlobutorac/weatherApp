//
//  DetailsListViewModel.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 17/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DetailsListViewModel {
    private let disposeBag = DisposeBag()
    private let datasource: Datasource
    private let cityId: Int

    private let _details: BehaviorRelay<[Details]>!

    init(datasource: Datasource, cityId: Int, forecast: Forecast) {
        self.datasource = datasource
        self.cityId = cityId
        
        self._details = BehaviorRelay(value: DetailsListViewModel.initializeModel(from: forecast))
    }
    
    var details: Driver<[Details]> {
        return _details.asDriver()
    }
    
    var numberOfDetails: Int {
        return _details.value.count
    }
    
    func updateDetails() {
        datasource.getWeatherForecastObservable(for: cityId).asObservable()
            .bind(onNext: { [weak self] databaseQueryResult in
                switch databaseQueryResult {
                case .success(let result):
                    self?._details.accept(DetailsListViewModel.initializeModel(from: result))
                case .failure(let error):
                    print(error)
                }
            }).disposed(by: disposeBag)
    }
    
    private static func initializeModel(from forecast: Forecast) -> [Details] {
        var details = [Details]()
        
        details.append(Details.feelsLike(forecast.feelsLike))
        details.append(Details.wind(forecast.wind))
        details.append(Details.humidity(forecast.humidity))
        details.append(Details.pressure(forecast.pressure))
        details.append(Details.visibility(forecast.visibility))
        
        return details
    }
}

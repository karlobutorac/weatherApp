//
//  DatasourceManager.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 05/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DatasourceManager: Datasource {
    public static let shared = DatasourceManager()
    private let disposeBag = DisposeBag()
    
    private let _allForecasts: BehaviorRelay<DatabaseQueryResult<[Forecast]>>
    private var _allForecastsForId = [Int : BehaviorRelay<DatabaseQueryResult<Forecast>>]()
    
    private init() {
        _allForecasts = BehaviorRelay<DatabaseQueryResult<[Forecast]>>(value: DatabaseQueryResult.success(result: []))
        _allForecasts.asObservable().bind { [weak self] databaseQueryResult in
            switch databaseQueryResult {
            case .success(let result):
                result.forEach({self?._allForecastsForId[$0.id] = BehaviorRelay<DatabaseQueryResult<Forecast>>.init(value: DatabaseQueryResult.success(result: $0))})
            case .failure(let error):
                print(error)
            }
        }.disposed(by: disposeBag)
        
        switch CoreDataDatasource.shared.getAllForecasts() {
        case .success(let coreDataForecasts):
            _allForecasts.accept(DatabaseQueryResult.success(result: Forecast.createArray(from: coreDataForecasts)))
        case .failure(let error):
            _allForecasts.accept(DatabaseQueryResult.failure(error: error))
        }
    }
    
    func getAllWeatherForecastsObservable() -> Driver<DatabaseQueryResult<[Forecast]>> {
        return _allForecasts.asDriver()
    }
    
    func getWeatherForecastObservable(for id: Int) -> Driver<DatabaseQueryResult<Forecast>> {
        guard let forecast = _allForecastsForId[id] else {
            let noSuchElement = BehaviorRelay<DatabaseQueryResult<Forecast>>.init(value: DatabaseQueryResult.failure(error: "No such element"))
            _allForecastsForId[id] = noSuchElement
            return noSuchElement.asDriver()
        }
        
        return forecast.asDriver()
    }
    
    func pullLatestWeatherForecast(for id: Int) {
        NetworkDatasource.shared.getWeatherDetails(for: CoreDataDatasource.shared.getAllMyForecastsIds()) { [weak self] forecastNetworkResult in
            guard let self = self else {
                return
            }
            
            switch forecastNetworkResult {
            case .success(let jsonForecasts):
                if jsonForecasts.count != 1 {
                   self._allForecasts.accept(DatabaseQueryResult<[Forecast]>.failure(error: "Recieved invalid number of elements"))
                }
                
                self._allForecastsForId[jsonForecasts[0].id]?.accept(DatabaseQueryResult.success(result: Forecast.init(jsonForecast: jsonForecasts[0])))
                
            case .failure(let error):
                self._allForecasts.accept(DatabaseQueryResult<[Forecast]>.failure(error: error))
            }
        }
    }
    
    func pullAllLatestWeatherForecasts(){
        NetworkDatasource.shared.getWeatherDetails(for: CoreDataDatasource.shared.getAllMyForecastsIds()) { [weak self] forecastNetworkResult in
            switch forecastNetworkResult {
            case .success(let jsonForecasts):
                self?._allForecasts.accept(DatabaseQueryResult<[Forecast]>.success(result: Forecast.createArray(from: jsonForecasts)))
            case .failure(let error):
                self?._allForecasts.accept(DatabaseQueryResult<[Forecast]>.failure(error: error))
            }
        }
    }
}

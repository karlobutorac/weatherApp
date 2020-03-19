//
//  CoreDataDatasource.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 05/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import CoreData
import UIKit


enum ForecastCoreDataResult<T> {
    case success(forecasts: T)
    case failure(String)
}

class CoreDataDatasource {
    public static let shared = CoreDataDatasource()
    public let managedContext: NSManagedObjectContext!
    
    func saveForecasts(forecasts: [Forecast]){
        let forecastEntity = NSEntityDescription.entity(forEntityName: "ForecastCD", in: managedContext)!
        let savedForecasts = CoreDataDatasource.shared.getAllForecasts()
        
        
        for forecast in forecasts {
            var forecastCD: NSManagedObject?
            
            //check if forecast already exists, if true update else create new
            if case .success(let coreDataForecasts) = savedForecasts, coreDataForecasts.count != 0, coreDataForecasts.contains(where: { $0.id == forecast.id}) {
                forecastCD = coreDataForecasts.filter { $0.id == forecast.id }.first
            } else {
                forecastCD = NSManagedObject(entity: forecastEntity, insertInto: managedContext)
            }
            
            forecastCD?.setValue(Date(), forKey: "date")
            forecastCD?.setValue(forecast.name, forKey: "name")
            forecastCD?.setValue(forecast.currentTemp, forKey: "currentTemp")
            forecastCD?.setValue(forecast.maxTemp, forKey: "maxTemp")
            forecastCD?.setValue(forecast.minTemp, forKey: "minTemp")
            forecastCD?.setValue(forecast.id, forKey: "id")
            forecastCD?.setValue(forecast.feelsLike, forKey: "feelsLike")
            forecastCD?.setValue(forecast.humidity, forKey: "humidity")
            forecastCD?.setValue(forecast.pressure, forKey: "pressure")
            forecastCD?.setValue(forecast.visibility, forKey: "visibility")
            forecastCD?.setValue(forecast.wind, forKey: "wind")
        }
        
        do {
            try managedContext.save()
        } catch let error {
            debugPrint(error)
        }
    }
    
    
    func getAllForecasts() -> ForecastCoreDataResult<[ForecastCD]>{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ForecastCD")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            guard let forecasts = result as? [ForecastCD] else {
                return ForecastCoreDataResult.failure("Could not cast data to forecastCD")
            }
            
            return ForecastCoreDataResult.success(forecasts: forecasts)
            
        } catch let error {
            return ForecastCoreDataResult.failure(error.localizedDescription)
        }
    }
    
    func getForecast(for id: Int) -> ForecastCoreDataResult<ForecastCD> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ForecastCD")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            guard let forecasts = result as? [ForecastCD] else {
                return ForecastCoreDataResult.failure("Could not cast data to forecastCD")
            }
            
            if forecasts.count != 1 {
                return ForecastCoreDataResult.failure("Forecasts count != 0")
            }
            
            return ForecastCoreDataResult.success(forecasts: forecasts[0])
            
        } catch let error {
            return ForecastCoreDataResult.failure(error.localizedDescription)
        }
    }
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("Could not initialize core data") }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getAllMyForecastsIds() -> [Int]  {
        return [3186886,3191648,3193935,3190261]
    }
    
    func getMyForecastsCount() -> Int {
        return getAllMyForecastsIds().count
    }
    
}

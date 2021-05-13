//
//  CoredataManager.swift
//  DarkSky
//
//  Created by Namrata Akash on 13/05/21.
//

import Foundation
import CoreData


struct CoredataManager {
    
    let mainContext: NSManagedObjectContext

    init(mainContext: NSManagedObjectContext = CoredataStack.shared.mainContext) {
        self.mainContext = mainContext
    }

    @discardableResult
    func createWeatherData(lat: Float,long:Float) -> Weather? {
        let weather = Weather(context: mainContext)
        
        weather.lat = lat
        weather.long = long
        
        do {
            try mainContext.save()
            return weather
        } catch let error {
            print("Failed to create: \(error)")
        }
        
        return nil
    }
    
    func fetchWeatherData() -> [Weather]? {
        let fetchRequest = NSFetchRequest<Weather>(entityName: "Weather")
        
        do {
            let weatherdata = try mainContext.fetch(fetchRequest)
            print(weatherdata)
            return weatherdata
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }
        
        return nil
    }
    
    func fetchweatherdatas(with lat:Float,long:Float) -> Weather? {
        let fetchRequest = NSFetchRequest<Weather>(entityName: "Weather")
        fetchRequest.fetchLimit = 2
//        fetchRequest.predicate = NSPredicate(format: " lat =", lat)
//        fetchRequest.predicate = NSPredicate(format: " long =", long)
        
        do {
            let weatherdatas = try mainContext.fetch(fetchRequest)
            return weatherdatas.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }
        
        return nil
    }
    
    func updateweather(weather: Weather) {
        do {
            try mainContext.save()
        } catch let error {
            print("Failed to update: \(error)")
        }
    }
    
    func deleteweather(weatherr: Weather) {
        mainContext.delete(weatherr)
        
        do {
            try mainContext.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }
}


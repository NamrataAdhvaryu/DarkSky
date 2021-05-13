//
//  Weather+CoreDataProperties.swift
//  DarkSky
//
//  Created by Namrata Akash on 13/05/21.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var date: Float
    @NSManaged public var feel_like: Float
    @NSManaged public var lat: Float
    @NSManaged public var long: Float
    @NSManaged public var temperature: Float

}

extension Weather : Identifiable {

}

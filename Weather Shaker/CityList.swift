//
//  CityList.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/15/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import Foundation
import os.log


class CityList: NSObject, NSCoding {
    
    var coordinates: String
    var cityName: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("cityList")
    
    
    init(coordinates: String, cityName: String) {
       self.coordinates = coordinates
        self.cityName = cityName
    }
    
    func setCityname(cityName: String) {
        self.cityName = cityName
    }
    
    func setCoordinates(coordinates: String) {
        self.coordinates = coordinates
    }
    
    func getCityName() -> String {
        return cityName
    }
    
    func getCoordinates() -> String {
        return coordinates
    }
    
    struct PropertyKey {
        
        static let coordinates = "coordinates"
        static let cityName = "cityName"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(cityName, forKey: PropertyKey.cityName)
        aCoder.encode(coordinates, forKey: PropertyKey.coordinates)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let cityName = aDecoder.decodeObject(forKey: PropertyKey.cityName) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let coordinates = aDecoder.decodeObject(forKey: PropertyKey.coordinates) as? String
        self.init(coordinates: coordinates!, cityName: cityName)
    }
}

//
//  Settings.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 7/20/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import Foundation
import os.log

class Settings: NSObject, NSCoding {
    
    var unitIsUS: String
    var defaultIsLocation: String
    var adIsDisabled: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("settings")
    
    
    init(unitIsUS: String, defaultIsLocation: String, adIsDisabled: String) {
        self.unitIsUS = unitIsUS
        self.defaultIsLocation = defaultIsLocation
        self.adIsDisabled = adIsDisabled
    }
    
    func setUnit(unitIsUs: String) {
        self.unitIsUS = unitIsUs
    }
    
    func setDefaultLocation(defaultIsLocation: String) {
        self.defaultIsLocation = defaultIsLocation
    }

    func setAdStatus(adIsDisabled: String) {
        self.adIsDisabled = adIsDisabled
    }
    
    func getUnitType() -> String {
        return unitIsUS
    }
    
    func getDefaultLocation() -> String {
        return defaultIsLocation
    }
    
    func getAdStatus() -> String {
        return adIsDisabled
    }
    
 
    
    
    struct PropertyKey {
        static let unitIsUS = "unitIsUS"
        static let defaultIsLocation = "defaultIsLocation"
        static let adIsDisabled = "adIsDisabled"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(unitIsUS, forKey: PropertyKey.unitIsUS)
        aCoder.encode(defaultIsLocation, forKey: PropertyKey.defaultIsLocation)
        aCoder.encode(adIsDisabled, forKey: PropertyKey.adIsDisabled)
    }
    
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let unitIsUS = aDecoder.decodeObject(forKey: PropertyKey.unitIsUS) as? String else {
            os_log("Unable to decode the name for a settings object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of Meal, just use conditional cast.
        let defaultIsLocation = aDecoder.decodeObject(forKey: PropertyKey.defaultIsLocation) as? String
        let adIsDisabled = aDecoder.decodeObject(forKey: PropertyKey.adIsDisabled) as? String

        // Must call designated initializer.
        self.init(unitIsUS: unitIsUS, defaultIsLocation: defaultIsLocation!, adIsDisabled: adIsDisabled!)
        
    }
    
}

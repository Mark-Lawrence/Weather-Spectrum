//
//  ColorAlgorithm.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 10/7/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import Foundation
import UIKit

class ColorAlgorithm{
    
    var hue = 0.0
    var saturation = 0.0
    var tempSaturation = 0.0
    var brightness = 100.0
    var tempBrightness = 100.0
    
    var color1 = UIColor()
    var color2 = UIColor()
    var color3 = UIColor()
    var color4 = UIColor()
    var color5 = UIColor()
    var color6 = UIColor()
    var color7 = UIColor()
    var color8 = UIColor()
    
    
    var initalColorArray = [Double]()
    
    func getNewColorArray(weatherData: forcastData) ->[UIColor]{
        getNewTemp(temperature: weatherData.getTemp())
        getNewCloudCoverage(cloudCoverage: weatherData.getCloudCoverage())
        initalColorArray = [hue/100, saturation/100, brightness/100]
        return createArray(initialColor: initalColorArray)
    }
    
    func getNewTemp(temperature: Int) {
        var temperature = temperature
        var userSettings = Settings(unitIsUS: "Fahrenheit", defaultIsLocation: "CurrentLocation", adIsDisabled: "false")
        
        if let attemptGetSettings = loadSettings() {
            userSettings = attemptGetSettings
        }
        
        if userSettings.getUnitType() == "celcius" {
            temperature = Int(Double(temperature)*1.8+32)
        }
        
        if temperature < 20{
            hue = 44
            tempSaturation = 40
        }
            
        else if temperature > 100 {
            hue = 50
            tempSaturation = 100
        }
        else{
            hue = Double((Double(temperature-20)*0.075)+44)
            tempSaturation = Double((Double(temperature-20)*0.75)+40)
        }
        tempBrightness = 100
    }
    
    func getNewCloudCoverage(cloudCoverage: Double) {
        print("CLOUD COVERAGE \(cloudCoverage)")
        let cloud = Double(cloudCoverage)/1.15
        saturation = tempSaturation * (1 - (0.75*cloud))
        brightness = tempBrightness * (1 - (0.25*cloud))
    }
    
    func createArray(initialColor: [Double]) -> [UIColor] {
        
        let initialColor0 = initialColor[0]+0.026
        let initialColor2 = initialColor[2]-0.01
        
        color2 = UIColor(hue: CGFloat(initialColor0+0.026), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.01), alpha: 1.0)
        color3 = UIColor(hue: CGFloat(initialColor0+0.0523), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.02), alpha: 1.0)
        color4 = UIColor(hue: CGFloat(initialColor0+0.0784), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.04), alpha: 1.0)
        color5 = UIColor(hue: CGFloat(initialColor0+0.105), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.06), alpha: 1.0)
        color6 = UIColor(hue: CGFloat(initialColor0+0.1307), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.07), alpha: 1.0)
        color7 = UIColor(hue: CGFloat(initialColor0+0.1569), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.08), alpha: 1.0)
        color8 = UIColor(hue: CGFloat(initialColor0+0.183), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.1), alpha: 1.0)
        color1 = UIColor(hue: CGFloat(initialColor0+0.2093), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.11), alpha: 1.0)
        
        return [color2, color3, color4, color5, color6, color7, color8, color1]
    }
    private func loadSettings() -> Settings?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Settings.ArchiveURL.path) as? Settings
    }
}


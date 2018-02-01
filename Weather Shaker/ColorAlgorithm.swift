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
        print("HUE \(hue)   Saturation \(saturation)")
        initalColorArray = [hue/100, saturation/100, brightness/100]
        return createArrayDay(initialColor: initalColorArray)
    }
    
    func getNewNightArray(weatherData: forcastData) -> [UIColor] {
        var moonPhase = weatherData.getMoonPhase()
        if moonPhase >= 0.5{
            moonPhase = 1 - moonPhase
        }
        hue = Double(238 + (32 * (moonPhase*2)))
        saturation = Double(67 + (11 * (moonPhase*2)))
        brightness = Double(74 + (10 * (moonPhase*2)))
        
        print("HUE \(hue)   Saturation \(saturation)")
        print(weatherData.getMoonPhase())
        
        initalColorArray = [hue/360, saturation/100, brightness/100]

        return createArrayNight(initialColor: initalColorArray)
    }
    
    func getRainArray(weatherData: forcastData) -> [UIColor] {
        let rainIntensity = weatherData.getRainIntensity()
        
        hue = Double(197 + (17*rainIntensity))
        saturation = 14.0
        brightness = Double(84 - (17*rainIntensity))
        
        print(hue)
        print(saturation)
        print(brightness)
        
        print(hue + 0.029*360)
        print(saturation + 60.9)
        print(brightness-11.375)
        
        initalColorArray = [hue/360, saturation/100, brightness/100]

        return createRainArray(initialColor: initalColorArray)
    }
    
    func getNewTemp(temperature: Int) {
        var temperature = temperature
        var userSettings = Settings(unitIsUS: "Fahrenheit", defaultIsLocation: "CurrentLocation", adIsDisabled: "false", allowAdvisories: "false", allowWatches: "false", allowWarnings: "true")
        
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
    
    func createArrayDay(initialColor: [Double]) -> [UIColor] {
        
        let initialColor0 = initialColor[0]+0.026
        let initialColor2 = initialColor[2]-0.01
        
        
        color2 = UIColor(hue: CGFloat(initialColor0+0.02287), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.01), alpha: 1.0)
        color3 = UIColor(hue: CGFloat(initialColor0+0.045575), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.02), alpha: 1.0)
        color4 = UIColor(hue: CGFloat(initialColor0+0.068625), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.04), alpha: 1.0)
        color5 = UIColor(hue: CGFloat(initialColor0+0.0915), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.06), alpha: 1.0)
        color6 = UIColor(hue: CGFloat(initialColor0+0.114375), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.07), alpha: 1.0)
        color7 = UIColor(hue: CGFloat(initialColor0+0.13725), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.08), alpha: 1.0)
        color8 = UIColor(hue: CGFloat(initialColor0+0.1601), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.1), alpha: 1.0)
        color1 = UIColor(hue: CGFloat(initialColor0+0.183), saturation: CGFloat(initialColor[1]), brightness: CGFloat(initialColor2-0.11), alpha: 1.0)
        
        return [color2, color3, color4, color5, color6, color7, color8, color1]
    }
    
    func createArrayNight(initialColor: [Double]) -> [UIColor] {
        
        let initialColor0 = initialColor[0]-0.005
        let initialColor1 = initialColor[1]-0.02
        let initialColor2 = initialColor[2]
        
        color1 = UIColor(hue: CGFloat(initialColor0+0.005), saturation: CGFloat(initialColor1+0.02), brightness: CGFloat(initialColor2), alpha: 1.0)
        color2 = UIColor(hue: CGFloat(initialColor0+0.01), saturation: CGFloat(initialColor1+0.052), brightness: CGFloat(initialColor2-0.041), alpha: 1.0)
        color3 = UIColor(hue: CGFloat(initialColor0+0.015), saturation: CGFloat(initialColor1+0.07875), brightness: CGFloat(initialColor2-0.0825), alpha: 1.0)
        color4 = UIColor(hue: CGFloat(initialColor0+0.02), saturation: CGFloat(initialColor1+0.105), brightness: CGFloat(initialColor2-0.123), alpha: 1.0)
        color5 = UIColor(hue: CGFloat(initialColor0+0.025), saturation: CGFloat(initialColor1+0.131), brightness: CGFloat(initialColor2-0.165), alpha: 1.0)
        color6 = UIColor(hue: CGFloat(initialColor0+0.03), saturation: CGFloat(initialColor1+0.1575), brightness: CGFloat(initialColor2-0.206), alpha: 1.0)
        color7 = UIColor(hue: CGFloat(initialColor0+0.035), saturation: CGFloat(initialColor1+0.18375), brightness: CGFloat(initialColor2-0.2476), alpha: 1.0)
        color8 = UIColor(hue: CGFloat(initialColor0+0.04), saturation: CGFloat(initialColor1+0.21), brightness: CGFloat(initialColor2-0.288), alpha: 1.0)
        
        return [color1, color2, color3, color4, color5, color6, color7, color8]
    }
    
    func createRainArray(initialColor: [Double]) -> [UIColor] {
        
        let initialColor0 = initialColor[0]
        let initialColor1 = initialColor[1]
        let initialColor2 = initialColor[2]
        
        color1 = UIColor(hue: CGFloat(initialColor0), saturation: CGFloat(initialColor1), brightness: CGFloat(initialColor2), alpha: 1.0)
        color2 = UIColor(hue: CGFloat(initialColor0+0.0041667), saturation: CGFloat(initialColor1), brightness: CGFloat(initialColor2-0.01625), alpha: 1.0)
        color3 = UIColor(hue: CGFloat(initialColor0+0.00833), saturation: CGFloat(initialColor1+0.1742), brightness: CGFloat(initialColor2-0.0325), alpha: 1.0)
        color4 = UIColor(hue: CGFloat(initialColor0+0.0125), saturation: CGFloat(initialColor1+0.261), brightness: CGFloat(initialColor2-0.04875), alpha: 1.0)
        color5 = UIColor(hue: CGFloat(initialColor0+0.0166), saturation: CGFloat(initialColor1+0.3485), brightness: CGFloat(initialColor2-0.065), alpha: 1.0)
        color6 = UIColor(hue: CGFloat(initialColor0+0.0208), saturation: CGFloat(initialColor1+0.4357), brightness: CGFloat(initialColor2-0.08125), alpha: 1.0)
        color7 = UIColor(hue: CGFloat(initialColor0+0.025), saturation: CGFloat(initialColor1+0.522), brightness: CGFloat(initialColor2-0.0975), alpha: 1.0)
        color8 = UIColor(hue: CGFloat(initialColor0+0.029), saturation: CGFloat(initialColor1+0.609), brightness: CGFloat(initialColor2-0.11375), alpha: 1.0)
        
        return [color1, color2, color3, color4, color5, color6, color7, color8]
    }
    private func loadSettings() -> Settings?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Settings.ArchiveURL.path) as? Settings
    }
}


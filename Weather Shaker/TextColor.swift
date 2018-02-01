//
//  TextColor.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 7/1/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import Foundation
import UIKit


class TextColor {
 
    
    let presunset1 = UIColor(red: 252.0/255.0, green: 155.0/255.0, blue: 39.0/255.0, alpha: 1.0)
    let presunset2 = UIColor(red: 245.0/255.0, green: 130.0/255.0, blue: 36.0/255.0, alpha: 1.0)
    let presunset3 = UIColor(red: 239.0/255.0, green: 109.0/255.0, blue: 34.0/255.0, alpha: 1.0)
    let presunset4 = UIColor(red: 233.0/255.0, green: 88.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    let presunset5 = UIColor(red: 229.0/255.0, green: 73.0/255.0, blue: 32.0/255.0, alpha: 1.0)
    let presunset6 = UIColor(red: 222.0/255.0, green: 49.0/255.0, blue: 32.0/255.0, alpha: 1.0)
    let presunset7 = UIColor(red: 215.0/255.0, green: 28.0/255.0, blue: 32.0/255.0, alpha: 1.0)
    let presunset8 = UIColor(red: 209.0/255.0, green: 11.0/255.0, blue: 33.0/255.0, alpha: 1.0)
   
    let postSunset1 = UIColor(red: 250.0/255.0, green: 140.0/255.0, blue: 94.0/255.0, alpha: 1.0)
    let postSunset2 = UIColor(red: 231.0/255.0, green: 125.0/255.0, blue: 110.0/255.0, alpha: 1.0)
    let postSunset3 = UIColor(red: 214.0/255.0, green: 112.0/255.0, blue: 125.0/255.0, alpha: 1.0)
    let postSunset4 = UIColor(red: 198.0/255.0, green: 99.0/255.0, blue: 140.0/255.0, alpha: 1.0)
    let postSunset5 = UIColor(red: 181.0/255.0, green: 86.0/255.0, blue: 157.0/255.0, alpha: 1.0)
    let postSunset6 = UIColor(red: 165.0/255.0, green: 75.0/255.0, blue: 172.0/255.0, alpha: 1.0)
    let postSunset7 = UIColor(red: 150.0/255.0, green: 65.0/255.0, blue: 187.0/255.0, alpha: 1.0)
    let postSunset8 = UIColor(red: 130.0/255.0, green: 52.0/255.0, blue: 207.0/255.0, alpha: 1.0)
    
    let nightDark1 = UIColor(red: 89.0/255.0, green: 94.0/255.0, blue: 101.0/255.0, alpha: 1.0)
    let nightDark2 = UIColor(red: 91.0/255.0, green: 86.0/255.0, blue: 103.0/255.0, alpha: 1.0)
    let nightDark3 = UIColor(red: 92.0/255.0, green: 78.0/255.0, blue: 105.0/255.0, alpha: 1.0)
    let nightDark4 = UIColor(red: 93.0/255.0, green: 70.0/255.0, blue: 107.0/255.0, alpha: 1.0)
    let nightDark5 = UIColor(red: 94.0/255.0, green: 63.0/255.0, blue: 109.0/255.0, alpha: 1.0)
    let nightDark6 = UIColor(red: 95.0/255.0, green: 55.0/255.0, blue: 111.0/255.0, alpha: 1.0)
    let nightDark7 = UIColor(red: 96.0/255.0, green: 47.0/255.0, blue: 112.0/255.0, alpha: 1.0)
    let nightDark8 = UIColor(red: 98.0/255.0, green: 39.0/255.0, blue: 115.0/255.0, alpha: 1.0)

    
    var backgoundColor = [CGColor]()
    //let colorAlgorithm = ColorAlgorithm()

    let white = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor as CGColor
    let navBarDay = UIColor(red: 217.0/255.0, green: 229.0/255.0, blue: 242.0/255.0, alpha: 1.0).cgColor as CGColor
    let navBarSun = UIColor(red: 243.0/255.0, green: 218.0/255.0, blue: 209.0/255.0, alpha: 1.0).cgColor as CGColor
    let navBarNight = UIColor(red: 227.0/255.0, green: 221.0/255.0, blue: 242.0/255.0, alpha: 1.0).cgColor as CGColor
    let navBarDayRain = UIColor(red: 220.0/255.0, green: 223.0/255.0, blue: 229.0/255.0, alpha: 1.0).cgColor as CGColor
    let navBarNightDark = UIColor(red: 210.0/255.0, green: 208.0/255.0, blue: 213.0/255.0, alpha: 1.0).cgColor as CGColor
    let navBarDayLight = UIColor(red: 228.0/255.0, green: 243.0/255.0, blue: 247.0/255.0, alpha: 1.0).cgColor as CGColor
    let navBarSunPost = UIColor(red: 249.0/255.0, green: 220.0/255.0, blue: 215.0/255.0, alpha: 1.0).cgColor as CGColor

    


    
    var textColor: TextColor?

    
    func getColorTextArray(data: forcastData, currentTime: Date) -> [UIColor] {
        
        var colorArray = [UIColor]()
        
        let sunsetTime = data.getSunsetTime()
        let sunriseTime = data.getSunriseTime()
        let icon = data.getIcon()
        var timeOfDayIfCloudy = ""
        
        let presunsetArray = [presunset1, presunset2, presunset3, presunset4, presunset5, presunset6, presunset7, presunset8]
        let postSunsetArray = [postSunset1, postSunset2, postSunset3, postSunset4, postSunset5, postSunset6, postSunset7, postSunset8]
        let nightDarkArray = [nightDark1, nightDark2, nightDark3, nightDark4, nightDark5, nightDark6, nightDark7, nightDark8]

        
        let calender:Calendar = Calendar.current
        let componentsNight: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentTime, to: sunsetTime)
        let componentsMorning: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentTime, to: sunriseTime)
        
        
        //Before Sunrise
        if componentsMorning.second! > 0 && componentsNight.second! > 0 {
            print("Early morning")
            
            if componentsMorning.minute! < 30 && componentsMorning.hour! == 0 {
                timeOfDayIfCloudy = "sunset"
                colorArray = postSunsetArray
            }
            else {
                timeOfDayIfCloudy = "night"
                colorArray = ColorAlgorithm().getNewNightArray(weatherData: data)
                print("IT IS THIS COLOR ARRAY")
                //colorArray = nightArray
            }
        }
            // After sunset
        else if componentsMorning.second! < 0 && componentsNight.second! < 0 {
            if componentsNight.minute! > -30 && componentsNight.hour! == 0{
                timeOfDayIfCloudy = "sunset"
                colorArray = postSunsetArray
            }
            else {
                timeOfDayIfCloudy = "night"
                colorArray = ColorAlgorithm().getNewNightArray(weatherData: data)
            }
        }
            // Day time
        else {
            if componentsNight.minute! < 30 && componentsNight.hour! == 0 && componentsNight.second! > 0 {
                timeOfDayIfCloudy = "sunset"
                colorArray = presunsetArray
            }
            else if componentsMorning.minute! > -30 && componentsMorning.hour! == 0{
               timeOfDayIfCloudy = "sunset"
                colorArray = presunsetArray
            }
                
            else {
                timeOfDayIfCloudy = "day"
                colorArray = ColorAlgorithm().getNewColorArray(weatherData: data)
                //colorArray = dayArray
            }
        }
        
        if icon == "rain" || icon == "fog"{
            if timeOfDayIfCloudy == "day"{
                colorArray = ColorAlgorithm().getRainArray(weatherData: data)
            }
            else{
                colorArray = nightDarkArray
            }
        }
        return colorArray
    }
    
    
    func updateBackground(data: forcastData) -> [CGColor] {
        

        let sunriseTime = data.getSunriseTime()
        let sunsetTime = data.getSunsetTime()
        let icon = data.getIcon()
        var timeOfDayIfCloudy = ""

        let currentTime = Date(timeIntervalSince1970: Double (Date().timeIntervalSince1970))
        let calender:Calendar = Calendar.current
        let componentsNight: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentTime, to: sunsetTime)
        let componentsMorning: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentTime, to: sunriseTime)
        
        
        //Before Sunrise
        if componentsMorning.second! > 0 && componentsNight.second! > 0 {
            print("Early morning")
            
            if componentsMorning.minute! < 30 && componentsMorning.hour! == 0 {
                print("30 min before sunrise")
                timeOfDayIfCloudy = "sunset"
                backgoundColor = [postSunset1.cgColor, postSunset8.cgColor, white, navBarSunPost]
  
            }
            else {
                print("Morning night")
                timeOfDayIfCloudy = "night"
                let color = ColorAlgorithm().getNewNightArray(weatherData: data)
                backgoundColor = [color[0].cgColor, color[7].cgColor, white, navBarNight]            }
            
        }
            
            // After sunset
        else if componentsMorning.second! < 0 && componentsNight.second! < 0 {
            if componentsNight.minute! > -30 && componentsNight.hour! == 0{
                print("30 min after sunset")
                timeOfDayIfCloudy = "sunset"
                backgoundColor = [postSunset1.cgColor, postSunset8.cgColor, white, navBarSunPost]
                
            }
                
                
            else {
                print("night")
                timeOfDayIfCloudy = "night"
                let color = ColorAlgorithm().getNewNightArray(weatherData: data)
                backgoundColor = [color[0].cgColor, color[7].cgColor, white, navBarNight]
            }
        }
            
            // Day time
        else {
            
            if componentsNight.minute! < 30 && componentsNight.hour! == 0 && componentsNight.second! > 0 {
                print("30 min before Sunset")
                timeOfDayIfCloudy = "sunset"
                backgoundColor = [presunset1.cgColor, presunset8.cgColor, white, navBarSun]
            }
                
            else if componentsMorning.minute! > -30 && componentsMorning.hour! == 0{
                print("30 min after sunrise")
                timeOfDayIfCloudy = "sunset"
                backgoundColor = [presunset1.cgColor, presunset8.cgColor, white, navBarSun]
            }
                
            else {
                print("day")
                let color = ColorAlgorithm().getNewColorArray(weatherData: data)
                timeOfDayIfCloudy = "day"
                backgoundColor = [color[0].cgColor, color[7].cgColor, white, navBarDay]
                print("day background")
                
            }
            
        }
        
        if icon == "rain"{
            if timeOfDayIfCloudy == "day"{
                let color = ColorAlgorithm().getRainArray(weatherData: data)
                backgoundColor = [color[0].cgColor,color[7].cgColor, white, navBarDayRain]
                print("rain background")
                print(data.getRainIntensity())
            }
            else{
                backgoundColor = [nightDark1.cgColor, nightDark8.cgColor, white, navBarNightDark]
            }
        }

        
        return backgoundColor
    }
    

    
    
    func updateIcon(data: String, sevenDay: Bool) -> UIImage {
        if data == "clear-day" {
            return #imageLiteral(resourceName: "clear")
        }
        if data == "cloudy" {
            return #imageLiteral(resourceName: "cloudy")
        }
        if data == "partly-cloudy-day" {
            return #imageLiteral(resourceName: "partly-cloudy")
        }
        if data == "rain" {
            return #imageLiteral(resourceName: "rain")
        }
        
        if sevenDay{
            if data == "clear-night"{
                return #imageLiteral(resourceName: "clear")
            }
            
            if data == "partly-cloudy-night"{
                return #imageLiteral(resourceName: "partly-cloudy")
            }
        }
        else{
            if data == "clear-night"{
                return #imageLiteral(resourceName: "clear-night-half")
            }
            
            if data == "partly-cloudy-night"{
                return #imageLiteral(resourceName: "partly-cloudy-night-half")
            }

        }
        
        if data == "snow"  {
            return #imageLiteral(resourceName: "snow")
        }
            
        if data == "sleet" {
            return #imageLiteral(resourceName: "snow")
        }
        
        if data == "wind" {
            return #imageLiteral(resourceName: "wind")
        }
            
        if data == "fog" {
            return #imageLiteral(resourceName: "fog")
        }
            
        else{
            return #imageLiteral(resourceName: "blank")
        }
    }
    
}

//
//  ForcastData.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/3/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import Foundation




struct forcastData {
    
    let dateFormatter = DateFormatter()
    
    var summary = ""
    var temperature = 0
    var icon = ""
    var humidity:Double = 0.0
    var pressure = 0
    var cloudCoverage = 0.0
    var windSpeed = 0
    var dewPoint = 0
    var feelsLike = 0
    var lastTimeUpdated = 0
    var timeZone = 0
    var sunsetTime = 0
    var sunriseTime = 0
    var moonPhase = 0.0
    var smartSummary = ""
    var uvIndex = 0
    var rainIntensity = 0.0
    
    var hourlyTime = [Int]()
    var hourlyIcon = [String]()
    var hourlyRainChance = [Double]()
    var hourlyTemp = [Int]()
    var hourlyPercipitationType = [String]()
    var hourlyWindSpeed = [Double]()
    var hourlyWindDirection = [Double]()
    var hourlyFeelsLike = [Int]()

    var weeklyTime = [Int]()
    var weeklyIcon = [String]()
    var weeklyHigh = [Int]()
    var weeklyLow = [Int]()
    var weeklyRainChance = [Double]()
    var weeklySummary = [String]()
    var weeklySunset = [Int]()
    var weeklySunrise = [Int]()
    var weeklyPercipitationType = [String]()

    var units = ""
    var location = ""
    var cityName = ""
    var alerts = [Alert]()


    
    
    init(summary: String, icon: String, feelsLike: Int, temperature: Int, dewPoint: Int, humidity: Double, pressure: Int, cloudCoverage: Double, windSpeed: Int, lastTimeUpdated: Int, timeZone: Int, sunsetTime: Int, sunriseTime: Int, moonPhase: Double, smartSummary: String, rainIntensity: Double, hourlyTime: [Int], hourlyIcon: [String], hourlyRainChance: [Double],hourlyTemp: [Int], weeklyTime: [Int], weeklyIcon: [String], weeklyHigh: [Int], weeklyLow: [Int], weeklyRainChance: [Double], weeklySummary:[String], location: String, cityName: String, uvIndex: Int, hourlyPercipitationType: [String], hourlyWindSpeed: [Double], hourlyWindDirection: [Double], hourlyFeelsLike: [Int], weeklySunrise: [Int], weeklySunset: [Int], weeklyPercipitationType: [String], units: String, alerts: [Alert]) {
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        self.cloudCoverage = cloudCoverage
        self.dewPoint = dewPoint
        self.windSpeed = windSpeed
        self.feelsLike = feelsLike
        self.lastTimeUpdated = lastTimeUpdated
        self.timeZone = timeZone
        self.sunsetTime = sunsetTime
        self.sunriseTime = sunriseTime
        self.moonPhase = moonPhase
        self.smartSummary = smartSummary
        self.uvIndex = uvIndex
        self.rainIntensity = rainIntensity
        
        
        self.hourlyTemp = hourlyTemp
        self.hourlyIcon = hourlyIcon
        self.hourlyTime = hourlyTime
        self.hourlyRainChance = hourlyRainChance
        self.hourlyPercipitationType = hourlyPercipitationType
        self.hourlyFeelsLike = hourlyFeelsLike
        self.hourlyWindDirection = hourlyWindDirection
        self.hourlyWindSpeed = hourlyWindSpeed
   
        
        self.weeklyTime = weeklyTime
        
        
        self.weeklyIcon = weeklyIcon
        self.weeklyHigh = weeklyHigh
        self.weeklyLow = weeklyLow
        self.weeklyRainChance = weeklyRainChance
        self.weeklySummary = weeklySummary
        self.weeklySunset = weeklySunset
        self.weeklySunrise = weeklySunrise
        self.weeklyPercipitationType = weeklyPercipitationType
        
        self.location = location
        self.cityName = cityName
        self.units = units
        self.alerts = alerts
    }
    

    
    func getTemperature() -> String {
        return String ("\(temperature)°")
    }
    
    func getTemp() -> Int {
        return temperature
    }
    
    func getCurrentCondition() -> String {
        return summary
    }
    
    func getHumidity() -> String {
        return String("\(Int (humidity*100))%")
    }
    
    func getPressure() -> String {
        return String("\(pressure) mb")
    }
    
    func getWindSpeed() -> String {
        if units == "Fahrenheit" {
            return String("\(windSpeed) mph")
        }
        else {
            return String("\(windSpeed) m/s")
        }
    }
    
    func getDewPoint() -> String {
        return String ("\(dewPoint)°")
    }
    
    func getFeelsLike() -> String {
        return String ("\(feelsLike)°")
    }
    
    func getIcon() -> String {
        return icon
    }
    func getCloudCoverage() -> Double {
        return cloudCoverage
    }
    
    func getLastUpdatedTime() -> String {
        return String (getFormatedTime(timeToFormat: lastTimeUpdated, dateFormatType: "EEEE, MMMM d", timeZoneSupprt: true))
    }
    func getLastUpdatedTimeAlert() -> String {
        return String (getFormatedTime(timeToFormat: lastTimeUpdated, dateFormatType: "MMMM d, h:mm a", timeZoneSupprt: true))
    }
    
    func getSunsetTime() -> Date {
         let date = Date(timeIntervalSince1970: Double (sunsetTime))
        return date
    
    }
    
    func getSunriseTime() -> Date {
        let date = Date(timeIntervalSince1970: Double (sunriseTime))
        return date
        
    }
    
    func getSunset() -> String {
        return String ("\(getFormatedTime(timeToFormat: sunsetTime, dateFormatType: "h:mm a", timeZoneSupprt: true))")
    }
    
    func getSunrise() -> String {
        
        return String ("\(getFormatedTime(timeToFormat: sunriseTime, dateFormatType: "h:mm a", timeZoneSupprt: true))")
    }
    
    func getSmartSummary() -> String {
        return smartSummary
    }
    
    func getUVIndex() -> String {
        return String (uvIndex)
    }
    
    func getMoonPhase() -> Double {
        return moonPhase
    }
    
    func getRainIntensity() -> Double {
        return rainIntensity
    }
    
    
    func getHourlyTime(formatType: String) -> [String] {
        var hourlyTimeString = [String]()
        for index in 0...36 {
            hourlyTimeString.insert(getFormatedTime(timeToFormat: hourlyTime[index], dateFormatType: formatType, timeZoneSupprt: true), at: index)
        }
        return hourlyTimeString
    }
    
    func getHourlyTimeDate() -> [Date] {
        var hourlyTimeToString = [Date]()
        for index in 0...36 {
           hourlyTimeToString.insert(Date(timeIntervalSince1970: Double (hourlyTime[index])), at: index)
            
        }
        return hourlyTimeToString
    }
    
    func getHourlyDayOfWeek() -> [String] {
        var hourlyDayOfWeekString = [String]()
        for index in 0...36 {
            hourlyDayOfWeekString.insert(getDayOfWeek(timeToFormat: hourlyTime[index]), at: index)
        }
        return hourlyDayOfWeekString
    }
    
    func getHourlyTemp() -> [String] {
        var hourlyTempString = [String]()
        for index in 0...36 {
            hourlyTempString.insert("\(hourlyTemp[index])°", at: index)
        }
        return hourlyTempString
    }
    func getHourlyRainChance() -> [String] {
        var hourlyRainString = [String]()
        for index in 0...36 {
            hourlyRainString.insert("\(Int (hourlyRainChance[index]*100))%", at: index)
        }
        return hourlyRainString
    }
    
    func getHourlyFeelsLike() -> [String] {
        var hourlyFeelsLikeString = [String]()
        for index in 0...36 {
            hourlyFeelsLikeString.insert("\(hourlyFeelsLike[index])°", at: index)
        }
        return hourlyFeelsLikeString
    }
    
    func getHourlyWindSpeed() -> [String] {
        return [String (describing: hourlyWindSpeed)]
    }
    
    func getHourlyWindDirection() -> [Double] {
        return hourlyWindDirection
    }
    
    func getHourlyRainChanceExtended() -> [String] {
        var hourlyRainString = [String]()
        for index in 0...36 {
            if hourlyRainChance[index] != 0{
                if hourlyPercipitationType[index] == "rain"{
                    hourlyRainString.insert("Chance of rain: \(Int (hourlyRainChance[index]*100))%", at: index)
                }
                else if hourlyPercipitationType[index] == "snow"{
                    hourlyRainString.insert("Chance of snow: \(Int (hourlyRainChance[index]*100))%", at: index)
                }
                else if hourlyPercipitationType[index] == "sleet"{
                    hourlyRainString.insert("Chance of sleet: \(Int (hourlyRainChance[index]*100))%", at: index)
                }
            }
            else{
                hourlyRainString.insert("", at: index)
            }
        }
        return hourlyRainString
    }
    
    func getHourlyIcon() -> [String] {
        return hourlyIcon
    }
    
    
    func getWeeklyTime() -> [String] {
        var weeklyTimeString = [String]()
        for index in 0...7 {
            weeklyTimeString.insert(getFormatedTime(timeToFormat: weeklyTime[index], dateFormatType: "MMM, d", timeZoneSupprt: true), at: index)
        }
        return weeklyTimeString
    }
    
   
    func getWeeklyHigh() -> [String] {
        var weeklyHighString = [String]()
        for index in 0...7 {
            weeklyHighString.insert("\(weeklyHigh[index])°", at: index)
        }
        return weeklyHighString
    }
    
    func getWeeklyLow() -> [String] {
        var weeklyLowString = [String]()
        for index in 0...7 {
            weeklyLowString.insert("\(weeklyLow[index])°", at: index)
        }
        return weeklyLowString
    }
    
    func getWeeklyRainChance() -> [String] {
        var weeklyRainChanceString = [String]()
        for index in 0...7 {
            weeklyRainChanceString.insert("\(Int (weeklyRainChance[index]*100))%", at: index)
        }
        return weeklyRainChanceString
    }
    
    func getWeeklySummary() -> [String] {
        return weeklySummary
    }
    
    func getWeeklyIcon() -> [String] {
        return weeklyIcon
    }
    
    func getWeeklyDayOfWeek() -> [String] {
        var weeklyDayOfWeek = [String]()
        for index in 0...7 {
            weeklyDayOfWeek.insert(getDayOfWeek(timeToFormat: weeklyTime[index]), at: index)
        }
        return weeklyDayOfWeek
    }
    
    func getWeeklyDayOfWeekLong() -> [String] {
        var weeklyDayOfWeek = [String]()
        for index in 0...7 {
            weeklyDayOfWeek.insert(getDayOfWeekLong(timeToFormat: weeklyTime[index]), at: index)
        }
        return weeklyDayOfWeek
    }
    
    func getWeeklyRainChanceExtended() -> [String] {
        var weeklyRainString = [String]()
        for index in 0...7 {
            if weeklyRainChance[index] != 0 {
                if weeklyPercipitationType[index] == "rain"{
                    weeklyRainString.insert("Chance of rain: \(Int (weeklyRainChance[index]*100))%", at: index)
                }
                else if weeklyPercipitationType[index] == "snow"{
                    weeklyRainString.insert("Chance of snow: \(Int (weeklyRainChance[index]*100))%", at: index)
                }
                else if weeklyPercipitationType[index] == "sleet"{
                    weeklyRainString.insert("Chance of sleet: \(Int (weeklyRainChance[index]*100))%", at: index)
                }
            }
            else{
                weeklyRainString.insert("", at: index)
            }
        }
        return weeklyRainString
    }


    
    func getLocation() -> String {
        return location
    }
    
    func getCityName() -> String {
        return cityName
    }

    func getAlerts() -> [Alert] {
        return alerts
    }
    
    func getFormatedTime(timeToFormat: Int, dateFormatType: String, timeZoneSupprt: Bool) -> String {
        
        let date = Date(timeIntervalSince1970: Double (timeToFormat))
        if timeZoneSupprt {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone*3600) //Set timezone that you want
        }
        
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = dateFormatType //Specify your format that you want
        
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    func getDayOfWeek(timeToFormat: Int) -> String {
        return String (getFormatedTime(timeToFormat: timeToFormat, dateFormatType: "EE", timeZoneSupprt: true))
    
    }
    func getDayOfWeekLong(timeToFormat: Int) -> String {
        
        return String (getFormatedTime(timeToFormat: timeToFormat, dateFormatType: "EEEE", timeZoneSupprt: true))
    }
    
}

class Alert {
    
    let dateFormatter = DateFormatter()
    
    var description = ""
    var expieres = 0
    var serverity = ""
    var time = 0
    var title = ""
    var alertURL = ""
    var timeZone = 0
    
    init(description: String, expieres: Int, serverity: String, time: Int, title: String, alertURL: String, timeZone: Int) {
        self.description = description
        self.expieres = expieres
        self.serverity = serverity
        self.time = time
        self.title = title
        self.alertURL = alertURL
        self.timeZone = timeZone
    }
   
    func getDescription() -> String {
        return description
    }
    
    func getExpiers() -> String {
        return String ("\(getFormatedTime(timeToFormat: expieres, dateFormatType: "MMMM d, h:mm a", timeZoneSupprt: true))")
    }
    
    
    func getServerity() -> String {
        return serverity
    }
    func getTime() -> String {
        return String ("\(getFormatedTime(timeToFormat: time, dateFormatType: "MMMM d, h:mm a", timeZoneSupprt: true))")
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getAlertURL() -> String {
        return alertURL
    }
    
    func getFormatedTime(timeToFormat: Int, dateFormatType: String, timeZoneSupprt: Bool) -> String {
        
        let date = Date(timeIntervalSince1970: Double (timeToFormat))
        if timeZoneSupprt {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone*3600) //Set timezone that you want
        }
        
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = dateFormatType //Specify your format that you want
        
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
}

//
//  HourlyMoreData.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 5/29/18.
//  Copyright © 2018 Mark Lawrence. All rights reserved.
//

import UIKit

class HourlyMoreData: NSObject {

    var summary = [String]()
    var feelsLike = [Int]()
    var humidity = [Double]()
    var windSpeed = [Double]()
    var windGust = [Double]()
    var uvIndex = [Int]()
    var cloudCoverage = [Double]()
    var rainIntensity = [Double]()
    var visibilty = [Double]()
    
    override init() {
    }
    
    init(summary: [String], feelsLike: [Int], humidity: [Double], windSpeed: [Double], windGust: [Double], uvIndex: [Int], cloudCoverage: [Double], rainIntensity: [Double], visibilty: [Double]) {
        self.summary = summary
        self.feelsLike = feelsLike
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.windGust = windGust
        self.uvIndex = uvIndex
        self.rainIntensity = rainIntensity
        self.cloudCoverage = cloudCoverage
        self.visibilty = visibilty
    }
}

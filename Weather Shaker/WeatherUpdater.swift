//
//  WeatherUpdater.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/10/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import Foundation

class WeatherUpdater{
    
    static let sharedInstance = WeatherUpdater()
    
    let weather = WeatherGetter()
    var viewController: ViewController?
    //var hourlyController: HourlyViewController?
    //var weeklyController: WeeklyViewController?
    var currentlyController: CurrentlyViewController?
    var cityListTableController: CityListTableController?
    var currentLocationController: CurrentLocationController?
    
    
    func setViewController(viewController: ViewController) {
        self.viewController = viewController
        WeatherGetter.sharedInstance.getViewController(viewController: viewController)
    }
    
//    func setHourlyController(hourlyController: HourlyViewController) {
//        self.hourlyController = hourlyController
//        WeatherGetter.sharedInstance.getHourlyController(hourlyController: hourlyController)
//    }
//    
//    func setWeeklyController(weeklyController: WeeklyViewController) {
//        self.weeklyController = weeklyController
//        WeatherGetter.sharedInstance.setWeeklyController(weeklyController: weeklyController)
//    }
//
//    func setCurrentlyController(currentlyController: CurrentlyViewController) {
//        self.currentlyController = currentlyController
//        WeatherGetter.sharedInstance.getCurrentlyController(currentlyController: currentlyController)
//    }
    
    func setcityListTableController(cityListTableController: CityListTableController) {
        self.cityListTableController = cityListTableController
    }
    
    func setCurrentLoctionCntroller(currentLocationController: CurrentLocationController)  {
        self.currentLocationController = currentLocationController
    }
    
    func getCityListTableController() -> CityListTableController {
        return cityListTableController!
    }
    func getCurrentLocationController() -> CurrentLocationController {
        return currentLocationController!
    }
    
    

    
    func updateWeather(coordnates: String, cityName: String, unit: String) {
        
        WeatherGetter.sharedInstance.getWeather(coordinates: coordnates, city: cityName)
    }
    
    func getViewController() -> ViewController {
        return viewController!
    }
    
    
    
    
}

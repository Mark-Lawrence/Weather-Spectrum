import Foundation
import UIKit

class WeatherGetter: UIView {
    
    var weatherData: forcastData?
    var viewController: ViewController?
    var hourlyController: HourlyViewController?
    var weeklyController: WeeklyViewController?
    var currentlyController: CurrentlyViewController?
    var hourlyCheck = 0
    var weeklyCheck = 0
    var currentlyCheck = 0
    
    
    static let sharedInstance = WeatherGetter()

    
    func getWeather(coordinates: String, city: String){
        
        var temp = 0
        var summary = ""
        var icon = ""
        var humidity:Double = 0.0
        var windspeed = 0
        var pressure = 0
        var cloudCoverage = 0.0
        var dewPoint = 0
        var feelsLike = 0
        var timeZone = 0
        var timeLastUpdated = 0
        var UVIndex = 0
        var units = ""
        
        
        let darkSkyAPIKey = "7ea99ae5cec66eeffd443d5f97b7a303"

//        var dataURL = "https://api.darksky.net/forecast/\(darkSkyAPIKey)/\(coordinates)?exclude=minutely,alerts,flags"

        var dataURL = "https://api.darksky.net/forecast/\(darkSkyAPIKey)/\(coordinates)"
        
        var userSettings = Settings(unitIsUS: "Fahrenheit", defaultIsLocation: "CurrentLocation", adIsDisabled: "false")
        
        if let attemptGetSettings = loadSettings() {
            userSettings = attemptGetSettings
        }
        
        if userSettings.getUnitType() == "celcius" {
            dataURL += "?units=si"
            units = "celcius"
        }
        
        else {
            units = "Fahrenheit"
        }
        
        let requestURL:NSURL = NSURL(string: dataURL)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        
        let session = URLSession.shared
        
                
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                do{
                    var sunset = 0
                    var sunrise = 0
                    var moonPhase = 0
                    var smartSummary = ""
                    
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
                    
                    let weather = try JSONSerialization.jsonObject(
                        with: data!,
                        options: .mutableContainers) as! [String: AnyObject]
                    print("GETTING NEW DATA")
                    
                    temp = Int(weather["currently"]!["temperature"]!! as! Double)
                    summary = weather["currently"]!["summary"]!! as! String
                    icon = weather["currently"]!["icon"]!! as! String
                    dewPoint = Int(weather["currently"]!["dewPoint"]!! as! Double)
                    humidity = weather["currently"]!["humidity"]!! as! Double
                    windspeed = Int(weather["currently"]!["windSpeed"]!! as! Double)
                    pressure = Int(weather["currently"]!["pressure"]!! as! Double)
                    cloudCoverage = weather["currently"]!["cloudCover"]!! as! Double
                    feelsLike = Int(weather["currently"]!["apparentTemperature"]!! as! Double)
                    timeLastUpdated = Int(weather["currently"]!["time"]!! as! Double)
                    timeZone = weather["offset"]! as! Int
                    UVIndex = Int(weather["currently"]!["uvIndex"]!! as! Double)
                    
                    
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : AnyObject]
                    
                    let daily = json?["daily"] as? [String : AnyObject]
                    let dailyData = daily?["data"] as? [[String : AnyObject]]
                    sunset = dailyData?[0]["sunsetTime"] as! Int
                    sunrise = dailyData?[0]["sunriseTime"] as! Int
                    moonPhase = Int(dailyData?[0]["moonPhase"] as! Double)
                    smartSummary = dailyData?[0]["summary"] as! String
                   
                    for index in 0...7 {
                        weeklyTime.insert(dailyData?[index]["time"] as! Int, at: index)
                        weeklyIcon.insert(dailyData?[index]["icon"] as! String, at: index)
                        weeklyHigh.insert (Int(dailyData?[index]["temperatureMax"] as! Double), at: index)
                        weeklyLow.insert(Int(dailyData?[index]["temperatureMin"] as! Double), at: index)
                        weeklyRainChance.insert(dailyData?[index]["precipProbability"] as! Double, at: index)
                        weeklySummary.insert(dailyData?[index]["summary"] as! String, at: index)
                        weeklySunrise.insert(dailyData?[index]["sunriseTime"] as! Int, at: index)
                        weeklySunset.insert(dailyData?[index]["sunsetTime"] as! Int, at: index)
                        
                        if weeklyRainChance[index] != 0 {
                            weeklyPercipitationType.insert(dailyData?[index]["precipType"] as! String, at: index)
                        }
                        else{
                            weeklyPercipitationType.insert("", at: index)
                        }
                    }
                    
                    let hourly = json?["hourly"] as? [String: AnyObject]
                    let hourlyData = hourly?["data"] as? [[String : AnyObject]]
                    
                    for index in 0...36 {
                        hourlyTime.insert(hourlyData?[index]["time"] as! Int, at: index)
                        hourlyIcon.insert(hourlyData?[index]["icon"] as! String, at: index)
                        hourlyRainChance.insert(hourlyData?[index]["precipProbability"] as! Double, at: index)
                        hourlyFeelsLike.insert(Int(hourlyData?[index]["apparentTemperature"] as! Double), at: index)
                        hourlyWindSpeed.insert(hourlyData?[index]["windSpeed"] as! Double, at: index)
                        if hourlyWindSpeed[index] != 0 {
                            hourlyWindDirection.insert(hourlyData?[index]["windBearing"] as! Double, at: index)
                        }
                        else{
                            hourlyWindDirection.insert(90, at: index)
                        }

                        hourlyTemp.insert(Int(hourlyData?[index]["temperature"] as! Double), at: index)
                        if hourlyRainChance[index] != 0 {
                            hourlyPercipitationType.insert(hourlyData?[index]["precipType"] as! String, at: index)
                        }
                        else{
                            hourlyPercipitationType.insert("", at: index)
                        }
                    }
                    
                    
                    self.weatherData = forcastData(summary: summary, icon: icon, feelsLike: feelsLike, temperature: temp, dewPoint: dewPoint, humidity: humidity, pressure: pressure, cloudCoverage: cloudCoverage, windSpeed: windspeed, lastTimeUpdated: timeLastUpdated, timeZone: timeZone, sunsetTime: sunset, sunriseTime: sunrise, moonPhase: moonPhase, smartSummary: smartSummary, hourlyTime: hourlyTime, hourlyIcon: hourlyIcon, hourlyRainChance: hourlyRainChance, hourlyTemp: hourlyTemp, weeklyTime: weeklyTime, weeklyIcon: weeklyIcon, weeklyHigh: weeklyHigh, weeklyLow: weeklyLow, weeklyRainChance: weeklyRainChance, weeklySummary: weeklySummary, location: coordinates, cityName: city, uvIndex: UVIndex, hourlyPercipitationType: hourlyPercipitationType, hourlyWindSpeed: hourlyWindSpeed, hourlyWindDirection: hourlyWindDirection, hourlyFeelsLike: hourlyFeelsLike, weeklySunrise: weeklySunrise, weeklySunset: weeklySunset, weeklyPercipitationType: weeklyPercipitationType, units: units)
                    
                    
                    DispatchQueue.main.sync {
                        self.getWeatherData(weatherData: self.weatherData!)
                    }
                    
                }
                catch {
                    print("Error with Json: \(error)")
                }
                
            }
                
            else{
                print("error downloading data")
            }
        }
        task.resume()
    }
    
    func getViewController(viewController: ViewController) {
        self.viewController = viewController
    }
    
    
    func getHourlyController(hourlyController: HourlyViewController) {
        self.hourlyController = hourlyController
    }
    
    func setWeeklyController(weeklyController: WeeklyViewController) {
        self.weeklyController = weeklyController
    }
    
    func getCurrentlyController(currentlyController: CurrentlyViewController) {
        self.currentlyController = currentlyController
    }
    
    
    
    func hourlyControllerDidLoad() {
        hourlyCheck = 1
        print("HOURLY DID LOAD")
    }
    
    func weeklyControllerDidLoad() {
        weeklyCheck = 1
        print("WEEKLY DID LOAD")
    }
    
    func currentlyControllerDidLoad() {
        currentlyCheck = 1
        print("CURRENTLY DID LOAD")
    }
    
    func getWeatherData(weatherData: forcastData) {
        
        viewController!.updateLabels(data: weatherData)
        
        
        if hourlyCheck == 1 {
            updateHourly()
        }
        
        if weeklyCheck == 1 {
            updateWeekly()
        }
        
        if currentlyCheck == 1 {
            updateCurrently()
        }
       
    }
    
    func updateHourly() {
        hourlyController!.updateLabels(data: weatherData!)
    }
    
    func updateWeekly() {
        weeklyController!.updateLabels(data: weatherData!)
    }
    func updateCurrently() {
        currentlyController!.updateLabels(data: weatherData!)
    }
    
    private func loadSettings() -> Settings?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Settings.ArchiveURL.path) as? Settings
    }

    
}

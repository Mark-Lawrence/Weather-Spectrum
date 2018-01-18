//
//  ViewController.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/27/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource {

    static var sharedInstance = ViewController()
    var locationManager: CLLocationManager = CLLocationManager()
    
    let uiColors = TextColor()
    var backgroundColorArray = [CGColor]()
    let gradient = CAGradientLayer()
    let navBar = CAGradientLayer()
    let screenSize = UIScreen.main.bounds
    var darkenBackground=UIView()
    var numberOfTimesCheckedForLocation = 0
    var tableSize: [[Int]] = [[1,2,3],[1]]
    
    
    @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
    @IBOutlet weak var loadViewBottom: NSLayoutConstraint!
    @IBOutlet weak var cityListTop: NSLayoutConstraint!
    @IBOutlet weak var dateLabelTop: NSLayoutConstraint!
    @IBOutlet weak var NavigationBar: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var navigationBarBackground: UIView!
    @IBOutlet weak var dynamicBackground: UIView!
    @IBOutlet weak var loadingView: UIView!
    
        
    var currentTemp = ""
    var currentCondition = ""
    var sunsetTime = ""
    var sunriseTime = ""
    var icon = ""
    
    
    var hourlyTime = ["","","",""]
    var hourlyTemp = ["","","",""]
    var hourlyRain = ["","","",""]
    
    var weeklyDay = ["","","",""]
    var weeklyHigh = ["","","",""]
    var weeklyLow = ["","","",""]
    var weeklyRain = ["","","",""]
    
    var cityData: CityList?
    var latitude: Double?
    var longitude: Double?
    var weatherData: forcastData?
    var cityName = ""
    var userSettings = Settings(unitIsUS: "Fahrenheit", defaultIsLocation: "CurrentLocation", adIsDisabled: "false")

    @IBOutlet weak var updateSpinner: UIActivityIndicatorView!
    
    var weatherUpdater = WeatherUpdater()

    
    func loadCurrentlyApp() {
        updateSpinner.isHidden = false
        
        
        if let attemptToLoadSettings = loadSettings(){
            userSettings = attemptToLoadSettings
        }
        print(  )
        print(userSettings.getAdStatus())
        let defaultCity = loadCities()

        if userSettings.getDefaultLocation() == "CurrentLocation" {
            //Decides to load current location or default location. If low powermode, opens default city
            if ProcessInfo.processInfo.isLowPowerModeEnabled {
                if defaultCity?.count != 0{
                    loadTopOfList(defaultCity: defaultCity![0])
                }
                else {
                    loadCurrentLocation()
                }
            }
            else {
                loadCurrentLocation()
            }
        }
        else {
            if defaultCity?.count != 0{
                loadTopOfList(defaultCity: defaultCity![0])
            }
            else {
               loadCurrentLocation()
            }
            
        }
        
        
        
        WeatherUpdater.sharedInstance.setViewController(viewController: self)
        print("load current")
    }
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 2436 {
                dateLabelTop.constant = 40
                cityListTop.constant = 40
                loadViewBottom.constant = -34
                tableViewBottom.constant = -200
            }
        }
        
        
        self.loadCurrentlyApp()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        loadingView.isHidden = false
        
        darkenBackground=UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        darkenBackground.backgroundColor = UIColor.black
        darkenBackground.alpha = 0.0
        darkenBackground.isUserInteractionEnabled = true
        self.view.addSubview(darkenBackground)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func forceUpdate() {
        updateSpinner.isHidden = false
        let cityCoordinates: String = cityData!.getCoordinates()
        let cityName: String = cityData!.getCityName()
        WeatherGetter.sharedInstance.getWeather(coordinates: cityCoordinates, city: cityName)
    }
    
    func forceUpdateWithLoaction() {
        if numberOfTimesCheckedForLocation == 1 {
            print("NewGPS Locatoon")
            updateSpinner.isHidden = false
            let cityCoordinates: String = cityData!.getCoordinates()
            let cityName: String = cityData!.getCityName()
            WeatherGetter.sharedInstance.getWeather(coordinates: cityCoordinates, city: cityName)
            
        }
        else {
            print("saved call to API")
        }
    }
    
    
    
    func updateLabels(data: forcastData) {
        cityNameLabel.text = data.getCityName()
        cityName = data.getCityName()
        dateLabel.text = data.getLastUpdatedTime().uppercased()
        
        currentTemp = data.getTemperature()
        currentCondition = data.getCurrentCondition()
        icon = data.getIcon()
        
        hourlyTime = data.getHourlyTime(formatType: "h:mm")
        hourlyTemp = data.getHourlyTemp()
        hourlyRain = data.getHourlyRainChance()
        
        weeklyDay = data.getWeeklyDayOfWeekLong()
        weeklyHigh = data.getWeeklyHigh()
        weeklyLow = data.getWeeklyLow()
        weeklyRain = data.getWeeklyRainChance()
        
        gradient.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        navBar.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 110)
        backgroundColorArray = uiColors.updateBackground(data: data)
        
        loadingView.isHidden = true
        
        gradient.colors = [backgroundColorArray[0] , backgroundColorArray[1]]
        navBar.colors = [backgroundColorArray[2], backgroundColorArray[3]]
        
        dynamicBackground.layer.addSublayer(gradient)
        navigationBarBackground.layer.addSublayer(navBar)
        
       
        weatherData = data
        updateSpinner.isHidden = true
        
        self.tableView.reloadData()
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentSummaryCell", for: indexPath) as! CurrentSummaryCell
            cell.iconImage.image = uiColors.updateIcon(data: icon, sevenDay: false)

            cell.temperatureLabel.text = currentTemp
            cell.conditionLabel.text = currentCondition
        
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "hourlySummaryCell", for: indexPath) as! HourlySummaryCell
            
            cell.firstHour.text = hourlyTime[0]
            cell.secondHour.text = hourlyTime[1]
            cell.thridHour.text = hourlyTime[2]
            cell.fourthHour.text = hourlyTime[3]

            cell.firstTemp.text = hourlyTemp[0]
            cell.secondTemp.text = hourlyTemp[1]
            cell.thridTemp.text = hourlyTemp[2]
            cell.fourthTemp.text = hourlyTemp[3]

            cell.firstRain.text = hourlyRain[0]
            cell.secondRain.text = hourlyRain[1]
            cell.thirdRain.text = hourlyRain[2]
            cell.fourthRain.text = hourlyRain[3]
            return cell
        }
        
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "weeklySummaryCell", for: indexPath) as! WeeklySummaryCell
            
            cell.secondDay.text = weeklyDay[1]
            cell.thridDay.text = weeklyDay[2]
            cell.fourthDay.text = weeklyDay[3]
            
            cell.firstHigh.text = weeklyHigh[0]
            cell.secondHigh.text = weeklyHigh[1]
            cell.thirdHigh.text = weeklyHigh[2]
            cell.fourthHigh.text = weeklyHigh[3]
            cell.firstLow.text = weeklyLow[0]
            cell.secondLow.text = weeklyLow[1]
            cell.thridLow.text = weeklyLow[2]
            cell.fourthLow.text = weeklyLow[3]
            
            cell.firstRain.text = weeklyRain[0]
            cell.secondRain.text = weeklyRain[1]
            cell.thridRain.text = weeklyRain[2]
            cell.fourthRain.text = weeklyRain[3]
            
            return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsTableViewCell
            return cell
        }
        
    }
    
    
   
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
            
            getPlacemark(forLocation: location) {
                (originPlacemark, error) in
                if let err = error {
                    print(err)
                                        
                    let alert: UIAlertController = UIAlertController(title: "Could not connect to the Internet", message: "Find an Internet connection and try again.", preferredStyle: .alert)
                    
                    let action1:UIAlertAction = UIAlertAction(title: "Retry", style: .cancel) { (_:UIAlertAction) in
                      self.loadCurrentlyApp()
                        
                        
                    }
            
                    alert.addAction(action1)

                    self.present(alert, animated: true) {
                    }

                    
                    
                } else if let placemark = originPlacemark {
                    // Do something with the placemark
                    let cityName: String = placemark.locality!
                    let coordinates: String = String ("\(self.latitude ?? 0.0),\(self.longitude ?? 0.0)")
                    
                    self.numberOfTimesCheckedForLocation += 1
                    self.cityData = CityList(coordinates: coordinates, cityName: cityName)
                    self.locationManager.stopUpdatingLocation()
                    self.forceUpdateWithLoaction()
                    
                }
            }
            
        }
    }
   
    
    @IBAction func unwindToCurrentWeather(sender: UIStoryboardSegue) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.darkenBackground.alpha = 0.0
        })
        
        if let sourceViewController = sender.source as? CityListTableController, let newCity = sourceViewController.newCity {
            cityData = newCity
            forceUpdate()
            
        }
        if let sourceViewController = sender.source as? CurrentLocationController, let newCity = sourceViewController.newCity {
            cityData = newCity
            forceUpdate()
        }
    }
    
    func getPlacemark(forLocation location: CLLocation, completionHandler: @escaping (CLPlacemark?, String?) -> ()) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location, completionHandler: {
            placemarks, error in
            
            if let err = error {
                completionHandler(nil, err.localizedDescription)
            } else if let placemarkArray = placemarks {
                if let placemark = placemarkArray.first {
                    completionHandler(placemark, nil)
                } else {
                    completionHandler(nil, "Placemark was nil")
                }
            } else {
                completionHandler(nil, "Unknown error")
            }
        })
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
    }

    func loadCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestLocation()
        print("GETTING GPS DATA")
    }
    
    func loadTopOfList(defaultCity: CityList) {
        cityData = defaultCity
        forceUpdate()
        print("GETTING DEFAULT CITY")
    }
    
    private func loadCities() -> [CityList]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: CityList.ArchiveURL.path) as? [CityList]
    }
    private func loadSettings() -> Settings?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Settings.ArchiveURL.path) as? Settings
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.navigationController?.navigationBar.backItem?.title = cityName
        
        if (segue.identifier == "toCityList") {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.darkenBackground.alpha = 0.28
            })
            
            let controller = segue.destination as! CityListViewController
            controller.darkColor = backgroundColorArray[0]
        }
        
        if (segue.identifier == "toSettings") {
            
            let controller = segue.destination as! AboutViewController
            controller.cityName = cityName
        }
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
}
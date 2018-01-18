//
//  HourlyViewController.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/9/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit

class HourlyViewController: UIViewController, UITableViewDataSource {
    
    

    static let sharedInstance = HourlyViewController()
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    let uiColors = TextColor()

    @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
    @IBOutlet weak var navBarBlurHeight: NSLayoutConstraint!
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var backButtonLabel: UILabel!
    @IBOutlet weak var hourlyLabel: UILabel!
    @IBOutlet weak var navBarEffect: UIVisualEffectView!
    
    var counter = 0
    var hourlyTime = [String]()
    var hourlyIcon = [String]()
    var hourlyRainChance = [String]()
    var hourlyTemp = [String]()
    var coordinates = ""
    var dayOfWeek = [String]()
    var cityName = ""
    var hourlyWindSpeed = [String]()
    var hourlyWindDirection = [Double]()
    var hourlyFeelsLike = [String]()
    var hourlyTimeDateFormat = [Date]()
    var sunriseTime: Date?
    var sunsetTime: Date?
    var textColor = [UIColor]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherGetter.sharedInstance.hourlyControllerDidLoad()
        WeatherUpdater.sharedInstance.setHourlyController(hourlyController: self)
        WeatherGetter.sharedInstance.updateHourly()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)


        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 2436 {
                backButtonLabel.frame.origin = CGPoint(x: 23, y: 55)
                hourlyLabel.frame.origin = CGPoint(x: 15, y: 80)
                navigationBar.frame = CGRect(x: 0, y: 0, width: 500, height: 600)
                navBarHeight.constant = 130
                navBarBlurHeight.constant = 130
                tableViewBottom.constant = -33
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateLabels(data: forcastData) {
        
        let currentTime = Date(timeIntervalSince1970: Double (Date().timeIntervalSince1970))
        textColor = uiColors.getColorTextArray(data: data, currentTime: currentTime)
        
        
        backButtonLabel.text = data.getCityName()
        hourlyLabel.textColor = textColor[7]
        hourlyTime = data.getHourlyTime(formatType: "h:mm a")
        hourlyIcon = data.getHourlyIcon()
        hourlyTemp = data.getHourlyTemp()
        hourlyRainChance = data.getHourlyRainChanceExtended()
        coordinates = data.getLocation()
        cityName = data.getCityName()
        dayOfWeek = data.getHourlyDayOfWeek()
        hourlyWindDirection = data.getHourlyWindDirection()
        hourlyFeelsLike = data.getHourlyFeelsLike()
        hourlyWindSpeed = data.getHourlyWindSpeed()
        hourlyTimeDateFormat = data.getHourlyTimeDate()
        sunriseTime = data.getSunriseTime()
        sunsetTime = data.getSunsetTime()
        
        navBar.layer.shadowColor = textColor[7].cgColor
        navBar.layer.shadowOpacity = 0.5
        navBar.layer.shadowOffset = CGSize.zero
        navBar.layer.shadowRadius = 12
     
        self.tableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyTime.count
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyCell", for: indexPath) as! HourlyTableViewCell
        
        
        cell.timeLabel.text = hourlyTime[indexPath.row]
        cell.tempLabel.text = hourlyTemp[indexPath.row]
        cell.chanceRainLabel.text = hourlyRainChance[indexPath.row]
        cell.dayOfWeekLabel.text = dayOfWeek[indexPath.row]
        cell.iconImage.image = uiColors.updateIcon(data: hourlyIcon[indexPath.row], sevenDay: false)

        
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 {
            cell.timeLabel.textColor = textColor[0]
            cell.dayOfWeekLabel.textColor = textColor[0]
            cell.currentLabel.textColor = textColor[0]
            cell.tempLabel.textColor = textColor[0]
            cell.chanceRainLabel.textColor = textColor[0]
        }
        else if indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 {
            cell.timeLabel.textColor = textColor[1]
            cell.dayOfWeekLabel.textColor = textColor[1]
            cell.currentLabel.textColor = textColor[1]
            cell.tempLabel.textColor = textColor[1]
            cell.chanceRainLabel.textColor = textColor[1]
        }
        else if indexPath.row == 8 || indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 11 {
            cell.timeLabel.textColor = textColor[2]
            cell.dayOfWeekLabel.textColor = textColor[2]
            cell.currentLabel.textColor = textColor[2]
            cell.tempLabel.textColor = textColor[2]
            cell.chanceRainLabel.textColor = textColor[2]
        }
        else if indexPath.row == 12 || indexPath.row == 13 || indexPath.row == 14 || indexPath.row == 15 {
            cell.timeLabel.textColor = textColor[3]
            cell.dayOfWeekLabel.textColor = textColor[3]
            cell.currentLabel.textColor = textColor[3]
            cell.tempLabel.textColor = textColor[3]
            cell.chanceRainLabel.textColor = textColor[3]
        }
        else if indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 18 || indexPath.row == 19 || indexPath.row == 20 {
            cell.timeLabel.textColor = textColor[4]
            cell.dayOfWeekLabel.textColor = textColor[4]
            cell.currentLabel.textColor = textColor[4]
            cell.tempLabel.textColor = textColor[4]
            cell.chanceRainLabel.textColor = textColor[4]
        }
        else if indexPath.row == 21 || indexPath.row == 22 || indexPath.row == 23 || indexPath.row == 24 || indexPath.row == 25 {
            cell.timeLabel.textColor = textColor[5]
            cell.dayOfWeekLabel.textColor = textColor[5]
            cell.currentLabel.textColor = textColor[5]
            cell.tempLabel.textColor = textColor[5]
            cell.chanceRainLabel.textColor = textColor[5]
        }
        
        else if indexPath.row == 26 || indexPath.row == 27 || indexPath.row == 28 || indexPath.row == 29 || indexPath.row == 30 {
            cell.timeLabel.textColor = textColor[6]
            cell.dayOfWeekLabel.textColor = textColor[6]
            cell.currentLabel.textColor = textColor[6]
            cell.tempLabel.textColor = textColor[6]
            cell.chanceRainLabel.textColor = textColor[6]
        }
            
        else {
            cell.timeLabel.textColor = textColor[7]
            cell.dayOfWeekLabel.textColor = textColor[7]
            cell.currentLabel.textColor = textColor[7]
            cell.tempLabel.textColor = textColor[7]
            cell.chanceRainLabel.textColor = textColor[7]
        }
        
       
    
        
        return cell
    }
    
    func refresh(sender:AnyObject) {
        WeatherGetter.sharedInstance.getWeather(coordinates: coordinates, city: cityName)
        refreshControl.endRefreshing()
    }
    
}

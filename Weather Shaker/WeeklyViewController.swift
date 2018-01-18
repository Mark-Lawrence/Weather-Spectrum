//
//  WeeklyViewController.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/11/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit
//import GoogleMobileAds

//GADBannerViewDelegate
class WeeklyViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var navigationBar: UIView!
    let uiColors = TextColor()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sevenDayLabel: UILabel!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    @IBOutlet weak var navBarBlurHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
    
    var weeklyTime = [String]()
    var weeklyIcon = [String]()
    var weeklyHigh = [String]()
    var weeklyLow = [String]()
    var weeklyRainChance = [String]()
    var weeklySummary = [String]()
    var coordinates = ""
    var cityName = ""
    var dayOfWeek = [String]()
    var textColor = [UIColor]()
    
    var weeklyData: forcastData?

    @IBOutlet weak var cityNameLabel: UILabel!
    
    static let sharedInstance = WeeklyViewController()
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 2436 {
                cityNameLabel.frame.origin = CGPoint(x: 23, y: 55)
                sevenDayLabel.frame.origin = CGPoint(x: 15, y: 70)
                navigationBar.frame = CGRect(x: 0, y: 0, width: 500, height: 600)
                navBarHeight.constant = 130
                navBarBlurHeight.constant = 130
                tableViewBottom.constant = -33
            }
        }

        
        // Do any additional setup after loading the view.
        WeatherGetter.sharedInstance.weeklyControllerDidLoad()
        WeatherUpdater.sharedInstance.setWeeklyController(weeklyController: self)
        WeatherGetter.sharedInstance.updateWeekly()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        
      
        
//            let request = GADRequest()
//            request.testDevices = [kGADSimulatorID]
//            
//            //set up ad
//            bannerAd.adUnitID = "ca-app-pub-7035758468741816/1092918969"
//            bannerAd.rootViewController = self
//            bannerAd.delegate = self
//            
//            bannerAd.load(request)
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabels(data: forcastData) {
        
        weeklyData = data
        
        let uiColors = TextColor()
        let currentTime = Date(timeIntervalSince1970: Double (Date().timeIntervalSince1970))
        textColor = uiColors.getColorTextArray(data: data, currentTime: currentTime)
        
        weeklyTime = data.getWeeklyTime()
        weeklyIcon = data.getWeeklyIcon()
        weeklyHigh = data.getWeeklyHigh()
        weeklyLow = data.getWeeklyLow()
        weeklyRainChance = data.getWeeklyRainChanceExtended()
        weeklySummary = data.getWeeklySummary()
        coordinates = data.getLocation()
        cityName = data.getCityName()
        dayOfWeek = data.getWeeklyDayOfWeek()
        
        sevenDayLabel.textColor = textColor[7]
        cityNameLabel.text = data.getCityName()
        
        navBar.layer.shadowColor = textColor[7].cgColor
        navBar.layer.shadowOpacity = 0.5
        navBar.layer.shadowOffset = CGSize.zero
        navBar.layer.shadowRadius = 12
        
   
        
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyCell", for: indexPath) as! WeeklyTableViewCell
        cell.dateLabel.text = weeklyTime[indexPath.row]
        cell.highLabel.text = weeklyHigh[indexPath.row]
        cell.lowLabel.text = weeklyLow[indexPath.row]
        cell.summaryLabel.text = weeklySummary[indexPath.row]
        cell.weekDayLabel.text = dayOfWeek[indexPath.row]
        cell.rainChanceLabel.text = weeklyRainChance[indexPath.row]

    
        cell.dateLabel.textColor = textColor[indexPath.row]
        cell.highLabel.textColor = textColor[indexPath.row]
        cell.lowLabel.textColor = textColor[indexPath.row]
        cell.rainChanceLabel.textColor = textColor[indexPath.row]
        cell.summaryLabel.textColor = textColor[indexPath.row]
        cell.weekDayLabel.textColor = textColor[indexPath.row]
        cell.tempLabelLine.textColor = textColor[indexPath.row]
        
        cell.iconImage.image = uiColors.updateIcon(data: weeklyIcon[indexPath.row], sevenDay: true)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let row = indexPath.row
        print(row)
    }
    
    
    func refresh(sender:AnyObject) {
        //  your code to refresh tableView
        WeatherGetter.sharedInstance.getWeather(coordinates: coordinates, city: cityName)
        refreshControl.endRefreshing()
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }
    
    private func loadSettings() -> Settings?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Settings.ArchiveURL.path) as? Settings
    }
    
    
   
}

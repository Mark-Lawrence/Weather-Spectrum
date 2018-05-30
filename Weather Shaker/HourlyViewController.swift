//
//  HourlyViewController.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/9/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass


//
class HourlyViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    
    static let sharedInstance = HourlyViewController()
    @IBOutlet weak var tableView: UITableView!
    let uiColors = TextColor()
    let screenSize = UIScreen.main.bounds
    var backgroundColorArray = [CGColor]()
    let gradient = CAGradientLayer()
    var navBarGradient = CAGradientLayer()
    var navBarColors = [CGColor]()


    @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
    @IBOutlet weak var navBarBlurHeight: NSLayoutConstraint!
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var backButtonLabel: UILabel!
    @IBOutlet weak var hourlyLabel: UILabel!
    @IBOutlet weak var navBarEffect: UIVisualEffectView!
    @IBOutlet weak var detailBlurView: UIVisualEffectView!
    
    @IBOutlet weak var tempTextLabel: UILabel!
    @IBOutlet weak var feelsLikeTextLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var humidityTestLabel: UILabel!
    @IBOutlet weak var uvIndexTextlabel: UILabel!
    @IBOutlet weak var rainChanceTextLabel: UILabel!
    @IBOutlet weak var rainIntensityTextLabel: UILabel!
    @IBOutlet weak var windSpeedTextLabel: UILabel!
    @IBOutlet weak var winsGustsTextLabel: UILabel!
    @IBOutlet weak var cloudTextLabel: UILabel!
    @IBOutlet weak var visibiltyTextLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    @IBOutlet weak var rainChanceLabel: UILabel!
    @IBOutlet weak var rainIntensityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windGustsLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var visibiltyLabel: UILabel!
    
  
    
    @IBOutlet weak var moreDetailTime: UILabel!
    @IBOutlet weak var square: UIView!
    var selectedRedView: UIView!
    var selectedRedViewSize: CGRect!
    let maxScaleFactor: CGFloat = 0.3
    let forcePercentageBeforeFired: CGFloat = 0.9
    var animatedViewDefualtSize: CGRect!

    
    var generator: UIImpactFeedbackGenerator!
    var touchx: CGFloat?
    var touchy: CGFloat?
    var moreDetailViewHeight = 0
    
    var newForce = true
    var forceTouch: ForceGestureRecognizer!
    var maximumForce: CGFloat!
    var force: CGFloat!
    var normalizedForce: CGFloat!
    var animation: CGAffineTransform!
    
    var counter = 0
    var hourlyTime = [String]()
    var hourlyIcon = [String]()
    var hourlyRainChance = [String]()
    var hourlyTemp = [String]()
    var coordinates = ""
    var dayOfWeek = [String]()
    var cityName = ""
    var hourlyTimeDateFormat = [Date]()
    var sunriseTime: Date?
    var sunsetTime: Date?
    var textColor = [UIColor]()
    var data: forcastData?
    var hourlyMoreData: HourlyMoreData!
    
    
    var is3DTouchAvailable: Bool {
        return view.traitCollection.forceTouchCapability == .available
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.isUserInteractionEnabled = true
        self.tableView.allowsSelection = true
        
        if is3DTouchAvailable{
            generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            forceTouch = ForceGestureRecognizer(target: self, action: #selector(forceTouched))
            forceTouch.delegate = self
            tableView.addGestureRecognizer(forceTouch)
        }
        detailBlurView.tag = 100
        square.tag = 101
        tableView.isUserInteractionEnabled = true
        
        detailBlurView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        square.frame.size = CGSize(width: 0, height: 0)
        square.layer.cornerRadius = 11
        square.layer.backgroundColor = navBarColors[1]
        self.detailBlurView.layer.opacity = 0
        
        self.tempTextLabel.layer.opacity = 0
        self.feelsLikeTextLabel.layer.opacity = 0
        self.summaryLabel.layer.opacity = 0
        self.humidityTestLabel.layer.opacity = 0
        self.uvIndexTextlabel.layer.opacity = 0
        self.rainChanceTextLabel.layer.opacity = 0
        self.rainIntensityTextLabel.layer.opacity = 0
        self.windSpeedTextLabel.layer.opacity = 0
        self.winsGustsTextLabel.layer.opacity = 0
        self.cloudTextLabel.layer.opacity = 0
        self.visibiltyTextLabel.layer.opacity = 0
        
        self.tempLabel.layer.opacity = 0
        self.feelsLikeLabel.layer.opacity = 0
        self.humidityLabel.layer.opacity = 0
        self.uvIndexLabel.layer.opacity = 0
        self.rainChanceLabel.layer.opacity = 0
        self.rainIntensityLabel.layer.opacity = 0
        self.windSpeedLabel.layer.opacity = 0
        self.windGustsLabel.layer.opacity = 0
        self.cloudsLabel.layer.opacity = 0
        self.visibiltyLabel.layer.opacity = 0
        
        
        
        animatedViewDefualtSize = CGRect(x: 10, y: 10, width: screenSize.width - 20, height: 80)
        
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 2436 {
                backButtonLabel.frame.origin = CGPoint(x: 23, y: 55)
                hourlyLabel.frame.origin = CGPoint(x: 15, y: 80)
                navBarHeight.constant = 130
                navBarBlurHeight.constant = 130
                tableViewBottom.constant = -33
            }
        }
        
        gradient.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        gradient.colors = [backgroundColorArray[0] , backgroundColorArray[1]]
        view.layer.addSublayer(gradient)
        navBar.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 110)
        navBarGradient.frame = navBar.frame
        navBarGradient.colors = [navBarColors[0], navBarColors[1]]
        navBar.layer.addSublayer(navBarGradient)
        
        
        updateLabels()
        
    }
    
  
    func forceTouched(gesture: ForceGestureRecognizer){

            
        if gesture.state == .began{

            let touchPosition :CGPoint = gesture.location(in: tableView)
            let newViewPosition: CGPoint = gesture.location(in: view)
            let indexPath = tableView.indexPathForRow(at: touchPosition)
            let selectedCell = tableView.cellForRow(at: indexPath!) as! HourlyTableViewCell
            
            updateMoreDetailView(index: (indexPath?.row)!)
            selectedRedView = selectedCell.animatedView
            selectedRedViewSize = selectedCell.animatedView.frame

            touchx = newViewPosition.x
            touchy = newViewPosition.y

        }
        
        if gesture.state == .changed{
            
            if gesture.forceValue > 1 && gesture.forceValue < gesture.maxValue - 1 && newForce{
                maximumForce = gesture.maxValue
                force = gesture.forceValue - 1
                normalizedForce = (force / maximumForce) + 1;
                animation = CGAffineTransform(scaleX: normalizedForce, y: normalizedForce)
                selectedRedView.transform = animation
                if Double(normalizedForce) > 1.2{
                    detailBlurView.layer.opacity = Float(normalizedForce - 1.2)
                }
            }
            
            if gesture.forceValue > gesture.maxValue - 1 && newForce{
                newForce = false
                animateMoreDetail()
            }
        }
        if gesture.state == .ended{
            newForce = true
            maximumForce = gesture.maxValue
            force = gesture.forceValue
            normalizedForce = (force / maximumForce) + 1.0;
            animation = CGAffineTransform(scaleX: normalizedForce, y: normalizedForce)
            selectedRedView.transform = animation
            
            UIView.animate(withDuration: 0.2, animations: {
                self.square.frame = CGRect(x: self.touchx!, y: self.touchy!, width: 0, height: 0)
                self.selectedRedView.frame = self.animatedViewDefualtSize
                self.detailBlurView.layer.opacity = 0
                self.square.layer.cornerRadius = 11
                
            })
            UIView.animate(withDuration: 0.1, animations: {
                self.tempTextLabel.layer.opacity = 0
                self.feelsLikeTextLabel.layer.opacity = 0
                self.summaryLabel.layer.opacity = 0
                self.humidityTestLabel.layer.opacity = 0
                self.uvIndexTextlabel.layer.opacity = 0
                self.rainChanceTextLabel.layer.opacity = 0
                self.rainIntensityTextLabel.layer.opacity = 0
                self.windSpeedTextLabel.layer.opacity = 0
                self.winsGustsTextLabel.layer.opacity = 0
                self.cloudTextLabel.layer.opacity = 0
                self.visibiltyTextLabel.layer.opacity = 0
                
                self.tempLabel.layer.opacity = 0
                self.feelsLikeLabel.layer.opacity = 0
                self.humidityLabel.layer.opacity = 0
                self.uvIndexLabel.layer.opacity = 0
                self.rainChanceLabel.layer.opacity = 0
                self.rainIntensityLabel.layer.opacity = 0
                self.windSpeedLabel.layer.opacity = 0
                self.windGustsLabel.layer.opacity = 0
                self.cloudsLabel.layer.opacity = 0
                self.visibiltyLabel.layer.opacity = 0
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func updateLabels() {
        hourlyLabel.textColor = textColor[7]
        hourlyTime = data!.getHourlyTime(formatType: "h:mm a")
        hourlyIcon = data!.getHourlyIcon()
        hourlyTemp = data!.getHourlyTemp()
        hourlyRainChance = data!.getHourlyRainChanceExtended()
        coordinates = data!.getLocation()
        cityName = data!.getCityName()
        dayOfWeek = data!.getHourlyDayOfWeek()
        hourlyTimeDateFormat = data!.getHourlyTimeDate()
        sunriseTime = data!.getSunriseTime()
        sunsetTime = data!.getSunsetTime()
        
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
        
        cell.selectionStyle = .none
        cell.timeLabel.text = hourlyTime[indexPath.row]
        cell.tempLabel.text = hourlyTemp[indexPath.row]
        cell.chanceRainLabel.text = hourlyRainChance[indexPath.row]
        cell.dayOfWeekLabel.text = dayOfWeek[indexPath.row]
        cell.iconImage.image = uiColors.updateIcon(data: hourlyIcon[indexPath.row], sevenDay: false)
        
        cell.animatedView.layer.frame = animatedViewDefualtSize
        return cell
    }
    
    func updateMoreDetailView(index: Int) {
        //moreDetailTime.text = hourlyTime[index]
        tempLabel.text = data?.getHourlyTemp()[index]
        feelsLikeLabel.text = "\(hourlyMoreData.feelsLike[index])º"
        humidityLabel.text = "\(Int(hourlyMoreData.humidity[index]*100))%"
        uvIndexLabel.text = "\(hourlyMoreData.uvIndex[index])"
        rainChanceLabel.text = data?.getHourlyRainChance()[index]
        rainIntensityLabel.text = "\(Int(hourlyMoreData.rainIntensity[index]*100))%"
        summaryLabel.text = hourlyMoreData.summary[index]
        windSpeedLabel.text = "\(Int(hourlyMoreData.windSpeed[index]))"
        windGustsLabel.text = "\(Int(hourlyMoreData.windGust[index]))"
        cloudsLabel.text = "\(Int(hourlyMoreData.cloudCoverage[index]*100))%"
        visibiltyLabel.text = "\(hourlyMoreData.visibilty[index]) mi"
        

    }
    func animateMoreDetail() {
        generator.impactOccurred()
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        if Double(touchy!) < (Double(screenHeight)/3){
            moreDetailViewHeight = Int(touchy!) + 200
        }
        else{
            moreDetailViewHeight = Int(touchy!) - 200
        }
        self.square.frame = CGRect(x: touchx!, y: touchy!, width: 0, height: 0)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.square.frame = CGRect(x: 10, y: self.moreDetailViewHeight, width: Int(screenWidth - 20), height: 134)
            self.detailBlurView.layer.opacity = 1
            self.square.layer.cornerRadius = 7
            })
        UIView.animate(withDuration: 0.3, animations: {
            //self.moreDetailTime.layer.opacity = 1
            self.tempTextLabel.layer.opacity = 1
            self.feelsLikeTextLabel.layer.opacity = 1
            self.summaryLabel.layer.opacity = 1
            self.humidityTestLabel.layer.opacity = 1
            self.uvIndexTextlabel.layer.opacity = 1
            self.rainChanceTextLabel.layer.opacity = 1
            self.rainIntensityTextLabel.layer.opacity = 1
            self.windSpeedTextLabel.layer.opacity = 1
            self.winsGustsTextLabel.layer.opacity = 1
            self.cloudTextLabel.layer.opacity = 1
            self.visibiltyTextLabel.layer.opacity = 1
            
            self.tempLabel.layer.opacity = 1
            self.feelsLikeLabel.layer.opacity = 1
            self.humidityLabel.layer.opacity = 1
            self.uvIndexLabel.layer.opacity = 1
            self.rainChanceLabel.layer.opacity = 1
            self.rainIntensityLabel.layer.opacity = 1
            self.windSpeedLabel.layer.opacity = 1
            self.windGustsLabel.layer.opacity = 1
            self.cloudsLabel.layer.opacity = 1
            self.visibiltyLabel.layer.opacity = 1
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer is UIPanGestureRecognizer || gestureRecognizer is ForceGestureRecognizer) {
            return true
        } else {
            return false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Add blur view subview")

        if let applicationDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate? {
            if let window:UIWindow = applicationDelegate.window {
                window.addSubview(detailBlurView)
                window.addSubview(square)
           }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParentViewController {
            if let applicationDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate? {
                if let window:UIWindow = applicationDelegate.window {
                    print("Remove blur subview")
                    let subViews = window.subviews
                    for subview in subViews{
                        if subview.tag == 100 || subview.tag == 101 {
                            subview.removeFromSuperview()
                        }
                    }
                }
            }
            
        }
    }

}

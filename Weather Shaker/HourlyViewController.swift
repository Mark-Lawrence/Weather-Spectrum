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
    
    @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
    @IBOutlet weak var navBarBlurHeight: NSLayoutConstraint!
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var backButtonLabel: UILabel!
    @IBOutlet weak var hourlyLabel: UILabel!
    @IBOutlet weak var navBarEffect: UIVisualEffectView!
    @IBOutlet weak var detailBlurView: UIVisualEffectView!
    
  
    
    @IBOutlet weak var moreDetailTime: UILabel!
    @IBOutlet weak var square: UIView!
    var selectedRedView: UIView!
    var selectedRedViewSize: CGRect!
    let maxScaleFactor: CGFloat = 0.3
    let forcePercentageBeforeFired: CGFloat = 0.9
    
    
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
    var hourlyWindSpeed = [String]()
    var hourlyWindDirection = [Double]()
    var hourlyFeelsLike = [String]()
    var hourlyTimeDateFormat = [Date]()
    var sunriseTime: Date?
    var sunsetTime: Date?
    var textColor = [UIColor]()
    var data: forcastData?
    
    
    var is3DTouchAvailable: Bool {
        return view.traitCollection.forceTouchCapability == .available
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.isUserInteractionEnabled = true
        self.tableView.allowsSelection = true
        generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
       
        forceTouch = ForceGestureRecognizer(target: self, action: #selector(forceTouched))
        forceTouch.delegate = self
        tableView.addGestureRecognizer(forceTouch)
        
        detailBlurView.tag = 100
        square.tag = 101
        tableView.isUserInteractionEnabled = true
        
        square.frame.size = CGSize(width: 0, height: 0)
        square.layer.cornerRadius = 11
        self.detailBlurView.layer.opacity = 0
        self.moreDetailTime.layer.opacity = 0
        
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
        gradient.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        gradient.colors = [backgroundColorArray[0] , backgroundColorArray[1]]
        view.layer.addSublayer(gradient)
        
        
        updateLabels()
        
    }
    
  
    func forceTouched(gesture: ForceGestureRecognizer){
        if gesture.state == .began{

            let touchPosition :CGPoint = gesture.location(in: tableView)
            let newViewPosition: CGPoint = gesture.location(in: view)
//            let positionOnScreen = tableView.indexPathsForVisibleRows
//            let oneOffIndexPath: IndexPath = tableView.indexPathForRow(at: position)!
            let indexPath = tableView.indexPathForRow(at: touchPosition)
//            let indexPath = NSIndexPath(row: oneOffIndexPath.row - 1, section: oneOffIndexPath.section)
//            let selectedCell = tableView.cellForRow(at: positionOnScreen![indexPath.row] as IndexPath) as! HourlyTableViewCell
//
            let selectedCell = tableView.cellForRow(at: indexPath!) as! HourlyTableViewCell
            
            moreDetailTime.text = hourlyTime[(indexPath?.row)!]
            selectedRedView = selectedCell.animatedView
            selectedRedViewSize = selectedCell.animatedView.frame
//            moreDetailTime.text = hourlyTime[positionOnScreen![indexPath.row].row]
//            selectedRedView = selectedCell.animatedView
//            selectedRedViewSize = selectedCell.animatedView.frame
            //}
            touchx = newViewPosition.x
            touchy = newViewPosition.y

        }
        
        if gesture.state == .changed{
            
            //if gesture.forceValue > 0.1{
            
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
                print("pop")
                animateMoreDetail()
            }
        }
        if gesture.state == .ended{
            newForce = true
            print("release")
            maximumForce = gesture.maxValue
            force = gesture.forceValue
            normalizedForce = (force / maximumForce) + 1.0;
            animation = CGAffineTransform(scaleX: normalizedForce, y: normalizedForce)
            selectedRedView.transform = animation
            
            UIView.animate(withDuration: 0.2, animations: {
                self.square.frame = CGRect(x: self.touchx!, y: self.touchy!, width: 0, height: 0)
                self.selectedRedView.frame = self.selectedRedViewSize
                self.detailBlurView.layer.opacity = 0
                self.square.layer.cornerRadius = 11
                
            })
            UIView.animate(withDuration: 0.1, animations: {
                self.moreDetailTime.layer.opacity = 0
            })
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
    
    func updateLabels() {
        backButtonLabel.text = data!.getCityName()
        hourlyLabel.textColor = textColor[7]
        hourlyTime = data!.getHourlyTime(formatType: "h:mm a")
        hourlyIcon = data!.getHourlyIcon()
        hourlyTemp = data!.getHourlyTemp()
        hourlyRainChance = data!.getHourlyRainChanceExtended()
        coordinates = data!.getLocation()
        cityName = data!.getCityName()
        dayOfWeek = data!.getHourlyDayOfWeek()
        hourlyWindDirection = data!.getHourlyWindDirection()
        hourlyFeelsLike = data!.getHourlyFeelsLike()
        hourlyWindSpeed = data!.getHourlyWindSpeed()
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

        
//        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 {
//            cell.timeLabel.textColor = textColor[0]
//            cell.dayOfWeekLabel.textColor = textColor[0]
//            cell.currentLabel.textColor = textColor[0]
//            cell.tempLabel.textColor = textColor[0]
//            cell.chanceRainLabel.textColor = textColor[0]
//        }
//        else if indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 {
//            cell.timeLabel.textColor = textColor[1]
//            cell.dayOfWeekLabel.textColor = textColor[1]
//            cell.currentLabel.textColor = textColor[1]
//            cell.tempLabel.textColor = textColor[1]
//            cell.chanceRainLabel.textColor = textColor[1]
//        }
//        else if indexPath.row == 8 || indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 11 {
//            cell.timeLabel.textColor = textColor[2]
//            cell.dayOfWeekLabel.textColor = textColor[2]
//            cell.currentLabel.textColor = textColor[2]
//            cell.tempLabel.textColor = textColor[2]
//            cell.chanceRainLabel.textColor = textColor[2]
//        }
//        else if indexPath.row == 12 || indexPath.row == 13 || indexPath.row == 14 || indexPath.row == 15 {
//            cell.timeLabel.textColor = textColor[3]
//            cell.dayOfWeekLabel.textColor = textColor[3]
//            cell.currentLabel.textColor = textColor[3]
//            cell.tempLabel.textColor = textColor[3]
//            cell.chanceRainLabel.textColor = textColor[3]
//        }
//        else if indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 18 || indexPath.row == 19 || indexPath.row == 20 {
//            cell.timeLabel.textColor = textColor[4]
//            cell.dayOfWeekLabel.textColor = textColor[4]
//            cell.currentLabel.textColor = textColor[4]
//            cell.tempLabel.textColor = textColor[4]
//            cell.chanceRainLabel.textColor = textColor[4]
//        }
//        else if indexPath.row == 21 || indexPath.row == 22 || indexPath.row == 23 || indexPath.row == 24 || indexPath.row == 25 {
//            cell.timeLabel.textColor = textColor[5]
//            cell.dayOfWeekLabel.textColor = textColor[5]
//            cell.currentLabel.textColor = textColor[5]
//            cell.tempLabel.textColor = textColor[5]
//            cell.chanceRainLabel.textColor = textColor[5]
//        }
//        
//        else if indexPath.row == 26 || indexPath.row == 27 || indexPath.row == 28 || indexPath.row == 29 || indexPath.row == 30 {
//            cell.timeLabel.textColor = textColor[6]
//            cell.dayOfWeekLabel.textColor = textColor[6]
//            cell.currentLabel.textColor = textColor[6]
//            cell.tempLabel.textColor = textColor[6]
//            cell.chanceRainLabel.textColor = textColor[6]
//        }
//            
//        else {
//            cell.timeLabel.textColor = textColor[7]
//            cell.dayOfWeekLabel.textColor = textColor[7]
//            cell.currentLabel.textColor = textColor[7]
//            cell.tempLabel.textColor = textColor[7]
//            cell.chanceRainLabel.textColor = textColor[7]
//        }

        return cell
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
            self.square.frame = CGRect(x: 15, y: self.moreDetailViewHeight, width: Int(screenWidth - 30), height: 100)
            self.detailBlurView.layer.opacity = 1
            self.square.layer.cornerRadius = 7
            })
        UIView.animate(withDuration: 0.3, animations: {
            self.moreDetailTime.layer.opacity = 1
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

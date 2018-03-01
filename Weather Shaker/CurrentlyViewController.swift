
//  CurrentlyViewController.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/27/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentlyViewController: UIViewController {

    @IBOutlet weak var temperatureLableBottom: NSLayoutConstraint!
    @IBOutlet weak var temperatureLabelTop: NSLayoutConstraint!
    @IBOutlet weak var CurrentlyTextTop: NSLayoutConstraint!
    @IBOutlet weak var summaryBottom: NSLayoutConstraint!
    @IBOutlet weak var backButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var dewPointLabel: UILabel!
    @IBOutlet weak var smartSummary: UILabel!
    @IBOutlet weak var backButtonLabel: UILabel!
    @IBOutlet weak var UVIndexLabel: UILabel!
    

    @IBOutlet weak var feelsLikeText: UILabel!
    @IBOutlet weak var UVIndexText: UILabel!
    @IBOutlet weak var dewPointText: UILabel!
    @IBOutlet weak var windText: UILabel!
    @IBOutlet weak var humidityText: UILabel!
    @IBOutlet weak var pressuretext: UILabel!
    @IBOutlet weak var sunriseText: UILabel!
    @IBOutlet weak var sunsetText: UILabel!
    @IBOutlet weak var currentlyText: UILabel!
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    let uiColors = TextColor()
    
    static let sharedInstance = CurrentlyViewController()
    var cityName = ""
    
    var textColor = [UIColor]()
    var data: forcastData?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 2436 {
                backButtonLabel.frame.origin = CGPoint(x: 23, y: 55)
                currentlyText.frame.origin = CGPoint(x: 15, y: 70)
                backButtonHeight.constant = 55
                CurrentlyTextTop.constant = 4
                //temperatureLabelTop.constant = 5
                temperatureLableBottom.constant = 5
            }
        }

        updateLabels()
        
//        WeatherGetter.sharedInstance.currentlyControllerDidLoad()
//        WeatherUpdater.sharedInstance.setCurrentlyController(currentlyController: self)
//        WeatherGetter.sharedInstance.updateCurrently()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateLabels() {
       
        //backButtonLabel.text = data!.getCityName()
        temperatureLabel.text = data!.getTemperature()
        windLabel.text = data!.getWindSpeed()
        humidityLabel.text = data!.getHumidity()
        pressureLabel.text = data!.getPressure()
        sunriseLabel.text = data!.getSunrise()
        sunsetLabel.text = data!.getSunset()
        conditionLabel.text = data!.getCurrentCondition()
        feelsLikeLabel.text = data!.getFeelsLike()
        dewPointLabel.text = data!.getDewPoint()
        smartSummary.text = data!.getSmartSummary()
        UVIndexLabel.text = data!.getUVIndex()
       
        currentlyText.textColor = textColor[7]
        feelsLikeText.textColor = textColor[0]
        UVIndexText.textColor = textColor[1]
        dewPointText.textColor = textColor[2]
        windText.textColor = textColor[3]
        humidityText.textColor = textColor[4]
        pressuretext.textColor = textColor[5]
        sunriseText.textColor = textColor[6]
        sunsetText.textColor = textColor[7]
        
        navBar.layer.shadowColor = textColor[7].cgColor
        navBar.layer.shadowOpacity = 0.25
        navBar.layer.shadowOffset = CGSize.zero
        navBar.layer.shadowRadius = 12
                
        iconImage.image = uiColors.updateIcon(data: data!.getIcon(), sevenDay: false)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}

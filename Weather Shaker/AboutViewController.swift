//
//  AboutViewController.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/13/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit
import os.log

class AboutViewController: UIViewController {

    
    var userSettings = Settings(unitIsUS: "Fahrenheit", defaultIsLocation: "CurrentLocation", adIsDisabled: "false", allowAdvisories: "false", allowWatches: "false", allowWarnings: "true")
    @IBOutlet weak var settingLabelTop: NSLayoutConstraint!
    @IBOutlet weak var backLabelTop: NSLayoutConstraint!
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    @IBOutlet weak var settingsTitle: UILabel!
    @IBOutlet weak var unitSelector: UISegmentedControl!
    @IBOutlet weak var defualtLocationSwitch: UISwitch!
    @IBOutlet weak var backButtonLabel: UILabel!
    var cityName = ""
    @IBOutlet weak var adSwitch: UISwitch!
    @IBOutlet weak var advisorySwitch: UISwitch!
    @IBOutlet weak var watchSwitch: UISwitch!
    @IBOutlet weak var warningSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 2436 {
                backLabelTop.constant = 57
                settingLabelTop.constant = 73
                navBarHeight.constant = 130

            }
        }

       backButtonLabel.text = cityName
        
        if let savedSettings = loadSettings() {
            userSettings = savedSettings
        }
        else {
            // Load the sample data.
            print("No saved settings")
        }
        
       
        if userSettings.getDefaultLocation() == "CurrentLocation" {
            defualtLocationSwitch.isOn = true
        }
        else {
            defualtLocationSwitch.isOn = false
        }
        
        
        if userSettings.getUnitType() == "Fahrenheit" {
            unitSelector.selectedSegmentIndex = 0
        }
        else {
            unitSelector.selectedSegmentIndex = 1
        }
        
        if userSettings.getAdvisories() == "false"{
            advisorySwitch.isOn = false
        }
        else{
            advisorySwitch.isOn = true
        }
        
        if userSettings.getWatches() == "false"{
            watchSwitch.isOn = false
        }
        else{
            watchSwitch.isOn = true
        }
        
        if userSettings.getWarnings() == "false"{
            warningSwitch.isOn = false
        }
        else{
            warningSwitch.isOn = true
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeUnitType(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        if (sender.titleForSegment(at: selectedIndex)) == "Fahrenheit" {
            print("Fahrenheit")
            userSettings.setUnit(unitIsUs: "Fahrenheit")
        }
        else{
            print("celcius")
            userSettings.setUnit(unitIsUs: "celcius")
        }
        saveSettings()
    }
    
    @IBAction func didChangeDefaultLocation(_ sender: UISwitch) {
        if !sender.isOn{
            userSettings.setDefaultLocation(defaultIsLocation: "TopOfList")
            saveSettings()
        }
        else{
            userSettings.setDefaultLocation(defaultIsLocation: "CurrentLocation")
            saveSettings()
        }
    }

//    @IBAction func didSwitchAds(_ sender: UISwitch) {
//        if !sender.isOn{
//            userSettings.setAdStatus(adIsDisabled: "false")
//            saveSettings()
//        }
//        else{
//            userSettings.setAdStatus(adIsDisabled: "true")
//            saveSettings()
//        }
//    }

    @IBAction func didSwitchAdvsiory(_ sender: UISwitch) {
        if !sender.isOn{
            userSettings.setAdvisories(allowAdvisories: "false")
            saveSettings()
        }
        else{
            userSettings.setAdvisories(allowAdvisories: "true")
            saveSettings()
        }
    }
    
    @IBAction func didSwitchWatch(_ sender: UISwitch) {
        if !sender.isOn{
            userSettings.setWatches(allowWatches: "false")
            saveSettings()
        }
        else{
            userSettings.setWatches(allowWatches: "true")
            saveSettings()
        }
    }
    
    @IBAction func didSwicthWarning(_ sender: UISwitch) {
        if !sender.isOn{
            userSettings.setWarnings(allowWarnings: "false")
            saveSettings()
        }
        else{
            userSettings.setWarnings(allowWarnings: "true")
            saveSettings()
        }
    }

    
    
    @IBAction func didPressPoweredBy(_ sender: Any) {
//        let url = URL(fileURLWithPath: "https://darksky.net/poweredby/")
//        UIApplication.shared.open(url, options: [:])
    UIApplication.shared.openURL(URL(string: "https://darksky.net/poweredby/")!)
    }
    
    private func saveSettings() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(userSettings, toFile: Settings.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Settings successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save settings...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadSettings() -> Settings?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Settings.ArchiveURL.path) as? Settings
    }

    override func didMove(toParentViewController parent: UIViewController?) {
        if (!(parent?.isEqual(self.parent) ?? false)) {
            print("Parent view loaded")
            let controller = WeatherUpdater.sharedInstance.getViewController()
            controller.forceUpdate()
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as! ViewController
        controller.forceUpdate()
        
    }
    

}

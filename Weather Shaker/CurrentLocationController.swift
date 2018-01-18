//
//  CurrentLocationController.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/19/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit
import CoreLocation


class CurrentLocationController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var UIView: UIView!
    @IBOutlet weak var updatingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addToListButton: UIButton!
    
    var locationManager: CLLocationManager = CLLocationManager()
    static var sharedInstance = CurrentLocationController()
    
    var latitude: Double?
    var longitude: Double?
    var newCityToAdd: CityList?
    var newCity: CityList?
    var cityList: [CityList] = []
    var viewController: CurrentLocationController?
    var cityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if loadCities() != nil{
        cityList = loadCities()!
        }
        else{
            print("else ran")
            cityList = []
        }
        viewController = self
        
        updatingIndicator.isHidden = false
        addToListButton.isEnabled = false
        
        WeatherUpdater.sharedInstance.setCurrentLoctionCntroller(currentLocationController: self)
        
        // Do any additional setup after loading the view.
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
            
            getPlacemark(forLocation: location) {
                (originPlacemark, error) in
                if let err = error {
                    print(err)
                } else if let placemark = originPlacemark {
                    // Do something with the placemark
                    self.locationManager.stopUpdatingLocation()
                    self.cityLabel.text = String (describing: placemark)
                    self.cityName = placemark.locality!
                    self.cityLabel.text = self.cityName
                    
                    let coordinates: String = String ("\(self.latitude ?? 0.0),\(self.longitude ?? 0.0)")
                    
                    self.newCityToAdd = CityList(coordinates: coordinates, cityName: self.cityName)
                    self.checkIfDuplicate(cityName: self.cityName)
                    self.updatingIndicator.isHidden = true
                }
            }
        }
    }
    
    
    func checkIfDuplicate(cityName: String) {
        var isDuplicate = false
        if cityList.count != 0 {
            for index in 0...(cityList.count-1) {
                if cityName == cityList[index].getCityName() {
                    addToListButton.isEnabled = false
                    isDuplicate = true
                }
            }
            if isDuplicate == false {
                addToListButton.isEnabled = true
            }
        }
        else{
            addToListButton.isEnabled = true
        }
    }
    @IBAction func didPressAdd(_ sender: Any) {
        
    }
    
    func getNewCityData() -> CityList {
        return newCityToAdd!
    }
    
    @IBAction func didPressButton(_ sender: Any) {
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "addCurrentLocationCity") {
            newCity = newCityToAdd
        }
        
        if (segue.identifier == "goToCurrently") {
            newCity = newCityToAdd
        }


        
    }

    
    func getPlacemark(forLocation location: CLLocation, completionHandler: @escaping (CLPlacemark?, String?) -> ()) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location, completionHandler: {
            placemarks, error in
            
            if let err = error {
                completionHandler(nil, err.localizedDescription)
                
                let alert: UIAlertController = UIAlertController(title: "Could not connect to the Internet", message: "Find an Internet connection and try again.", preferredStyle: .alert)
                
                let action1:UIAlertAction = UIAlertAction(title: "Retry", style: .cancel) { (_:UIAlertAction) in
                     self.locationManager.requestLocation()
                    
                    
                }
                
                alert.addAction(action1)
                
                self.present(alert, animated: true) {
                }
                
            } else if let placemarkArray = placemarks {
                if let placemark = placemarkArray.first {
                    completionHandler(placemark, nil)

                    print("New GPS Location")
                } else {
                    completionHandler(nil, "Placemark was nil")
                }
            } else {
                completionHandler(nil, "Unknown error")
            }
        })
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
    }
    
    private func loadCities() -> [CityList]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: CityList.ArchiveURL.path) as? [CityList]
    }

}

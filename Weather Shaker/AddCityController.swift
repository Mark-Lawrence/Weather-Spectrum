//
//  AddCityController.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/16/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit
import os.log
import CoreLocation

class AddCityController: UIViewController, UITextFieldDelegate, UITableViewDataSource {

    @IBOutlet weak var navBarheight: NSLayoutConstraint!
    @IBOutlet weak var detailTextTop: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var zipCodeTextFeild: UITextField!
    
    var newCity: CityList?
    var cityNameToDisplay: String?
    var citiesToDisplay: [String] = []
    var cityList: [CityList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 2436 {
                detailTextTop.constant = 33
                navBarheight.constant = 100
            }
        }

        
        zipCodeTextFeild.becomeFirstResponder();
        self.zipCodeTextFeild.delegate = self;
        
        // Do any additional setup after loading the view.
        activityIndicator.isHidden = true
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        //Make Romance Island work
        
        if zipCodeTextFeild.text == "Romance Island" || zipCodeTextFeild.text == "Oxtongue Lake" {
            self.cityNameToDisplay = "Oxtongue Lake"
            let city = "Oxtongue Lake"
            let coordinates = "45.376123,-78.920058"
            self.newCity = CityList(coordinates: coordinates, cityName: city)
            self.updateTable()
            self.activityIndicator.isHidden = true
            activityIndicator.isHidden = true
        }
        else {
            forwardGeocoding(address: zipCodeTextFeild.text!)
            activityIndicator.isHidden = false

        }
        self.zipCodeTextFeild.text = ""
        return false
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesToDisplay.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "citiesToAdd", for: indexPath) 
        cell.textLabel?.text = citiesToDisplay[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "addNewCityToList") {
            if let indexPath = tableView.indexPathForSelectedRow {
                newCity = cityList[indexPath.row]
            }
        }
        
        if (segue.identifier == "cancel") {
            print("CANCEL")
            newCity = nil
        }
        
    }
    
    
    @IBAction func didPressCancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    func forwardGeocoding(address: String) {
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                let alert: UIAlertController = UIAlertController(title: "Invalid Location", message: "Please enter a valid zip code, city name, or address", preferredStyle: .alert)
                let action1:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (_:UIAlertAction) in
                }
                alert.addAction(action1)
                self.present(alert, animated: true) {
                }
                self.zipCodeTextFeild.text = ""
                self.activityIndicator.isHidden = true
                return
            }
            
            if (placemarks?.count)! > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                let coordinates = "\(coordinate!.latitude),\(coordinate!.longitude)"
                
                if let city = placemark?.locality, let state = placemark!.administrativeArea{
                    self.cityNameToDisplay = "\(city) \(state)"
                    self.newCity = CityList(coordinates: coordinates, cityName: city)
                    self.updateTable()
                    self.activityIndicator.isHidden = true
                }
                
                else {
                    let alert: UIAlertController = UIAlertController(title: "Invalid Location", message: "Please enter a valid zip code, city name, or address", preferredStyle: .alert)
                    let action1:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (_:UIAlertAction) in
                    }
                    alert.addAction(action1)
                    self.present(alert, animated: true) {
                    }
                    self.zipCodeTextFeild.text = ""
                    self.activityIndicator.isHidden = true

                }
            }
        })
    }
    
    func updateTable() {
        
        let newIndexPath = IndexPath(row: 0, section: 0)
        
        
        citiesToDisplay.insert(cityNameToDisplay!, at: 0)
        cityList.insert(newCity!, at: 0)
        
        tableView.insertRows(at: [newIndexPath], with: .automatic)
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

//
//  CityListTableController.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/19/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit
import os.log

class CityListTableController: UITableViewController {
    
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var currentLocationUIView: UIView!
  
    
    var cityList: [CityList] = []
    var selectedCity: Int = 0
    
    var newCity: CityList?
    var currentLocationCityList: CityList?
    var currentLocationController: CurrentLocationController?
    var currentCity = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WeatherUpdater.sharedInstance.setcityListTableController(cityListTableController: self)
        currentLocationController = WeatherUpdater.sharedInstance.getCurrentLocationController()
        
        loadCityList()
        
               
        // Do any additional setup after loading the view.
        
        if let savedCityList = loadCities() {
            cityList += savedCityList
        }
        else {
            // Load the sample data.
            loadCityList()
        }
    }
    
    
    func beginEditMode() {
        tableView.setEditing(true, animated: true)
    }
    
    func endEditMode() {
        tableView.setEditing(false, animated: true)

    }
    
    func loadCityList() {
        cityList += []
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityList.count
    }


    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CityListCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityChooserCell", for: indexPath) as! CityListCell
                
        cell.cityNameLabel.text = cityList[indexPath.row].getCityName()
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            print(cityList[indexPath.row].getCityName())
            
            currentCity = currentLocationController!.cityName
            
            if cityList[indexPath.row].getCityName() == currentCity {
                currentLocationController?.addToListButton.isEnabled = true
            }
            
            cityList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        saveCityList()
    }
    
    


    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = cityList[fromIndexPath.row]
        cityList.remove(at: fromIndexPath.row)
        cityList.insert(itemToMove, at: to.row)
        saveCityList()
     }
    
    
    
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
    
    

    // MARK: - Navigation

    @IBAction func unwindToCityList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddCityController, let newCity = sourceViewController.newCity {
            
            var isDuplicate = false
            if cityList.count != 0 {
                
                for index in 0...(cityList.count - 1) {
                    if newCity.getCityName() == cityList[index].getCityName() {
                        isDuplicate = true
                    }
                }
            }
            if isDuplicate == false {
                let newIndexPath = IndexPath(row: cityList.count, section: 0)
                cityList.append(newCity)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            
            if newCity.getCityName() == currentLocationController?.cityName {
                currentLocationController?.addToListButton.isEnabled = false
            }
        }
        
        if let sourceViewController = sender.source as? CurrentLocationController, let newCity = sourceViewController.newCity, let viewController = sourceViewController.viewController {
            
            let newIndexPath = IndexPath(row: cityList.count, section: 0)
            
            viewController.addToListButton.isEnabled = false
            cityList.append(newCity)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            
        }
        // Save the city.
        saveCityList()
    }
    

    
    
//    func viewTapped(gesture: UIGestureRecognizer) {
//        // if the tapped view is a UIImageView then set it to imageview
//        if (gesture.view) != nil {
//            //performSegue(withIdentifier: "selectCurrentLocationCity", sender: nil);
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        if (segue.identifier == "selectNewCity") {
            if let indexPath = tableView.indexPathForSelectedRow {
                newCity = cityList[indexPath.row]
            }
        }
        
        if (segue.identifier == "selectCurrentLocationCity") {
        }

        
    }
    
    
    
    
    private func saveCityList() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(cityList, toFile: CityList.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadCities() -> [CityList]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: CityList.ArchiveURL.path) as? [CityList]
    }
    
    
}

    

//
//  AlertViewController.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 1/19/18.
//  Copyright © 2018 Mark Lawrence. All rights reserved.
//

import UIKit

class AlertViewController: ViewControllerPannable, UITableViewDataSource {
    var alertData = [Alert]()
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    let uiColors = TextColor()
    var textColor = [UIColor]()
    
    @IBOutlet weak var dragDownImageView: UIImageView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lastUpdated: UILabel!
    var dateLastUpdated = ""
    var weatherData: forcastData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lastUpdated.text = "Last Updated: \(dateLastUpdated)"
        backgroundView.layer.cornerRadius = 7
        blurView.layer.cornerRadius = 7
        blurView.clipsToBounds = true
        dragDownArrow = dragDownImageView
        
        let currentTime = Date(timeIntervalSince1970: Double (Date().timeIntervalSince1970))
        textColor = uiColors.getColorTextArray(data: weatherData!, currentTime: currentTime)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertData.count
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alertCell", for: indexPath) as! AlertTableViewCell
        cell.scrollView.showsVerticalScrollIndicator = true
        cell.title.text = alertData[indexPath.row].getTitle()
        cell.descriptionLabel.text = alertData[indexPath.row].getDescription()
        cell.url = alertData[indexPath.row].getAlertURL()
        cell.experationDate.text = "Expires on \(alertData[indexPath.row].getExpiers())"
        cell.date.text = alertData[indexPath.row].getTime()
        cell.scrollView.backgroundColor = textColor[7].withAlphaComponent(0.15)
        switch alertData[indexPath.row].getServerity() {
        case "advisory":
            cell.severity.text = "Advisory"
            cell.icon.image = #imageLiteral(resourceName: "Advisoryx2")
        case "watch":
            cell.severity.text = "Watch"
            cell.icon.image = #imageLiteral(resourceName: "Watchx2")
        case "warning":
            cell.severity.text = "Warning"
            cell.icon.image = #imageLiteral(resourceName: "Warning x2")
        default:
            print("not valid severity")
        }
        
        
        
        
        return cell
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

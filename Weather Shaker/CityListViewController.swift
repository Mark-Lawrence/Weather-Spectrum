//
//  CityListViewController.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 7/12/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit

class CityListViewController: ViewControllerPannable {


   
    
    @IBOutlet weak var boarderView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var blurBackground: UIVisualEffectView!
    @IBOutlet weak var addLabel: UILabel!
    
    var editCounter = 0
    var darkColor: CGColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let colorConverter = UIColor(cgColor: darkColor!)
        addLabel.textColor = colorConverter
        
        
        containerView.layer.cornerRadius = 7
        // Do any additional setup after loading the view.
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressEdit(_ sender: Any) {
        let controller = WeatherUpdater.sharedInstance.getCityListTableController()

        print(editCounter)
        
        if editCounter % 2 == 0 {
            editButton.setTitle("Done", for: .normal)
            controller.beginEditMode()
            editCounter = editCounter + 1
            
            dragDownArrow.image = #imageLiteral(resourceName: "dragDownArrowStraight")
            
            panGestureRecognizer?.isEnabled = false
            
            
            
        }
        else{
            editButton.setTitle("Edit", for: .normal)
            controller.endEditMode()
            editCounter = editCounter + 1
            dragDownArrow.image = #imageLiteral(resourceName: "dragDownArrow")
            
            panGestureRecognizer?.isEnabled = true

        }
 
    }

//    func getEditStatus() -> Bool {
//        return isEditMode
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

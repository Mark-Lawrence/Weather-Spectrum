//
//  WeeklySummaryCell.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/28/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit

class WeeklySummaryCell: UITableViewCell {

    @IBOutlet weak var whiteBackgroundLayer: UIView!
    @IBOutlet weak var secondDay: UILabel!
    @IBOutlet weak var thridDay: UILabel!
    @IBOutlet weak var fourthDay: UILabel!
    
    @IBOutlet weak var firstHigh: UILabel!
    @IBOutlet weak var secondHigh: UILabel!
    @IBOutlet weak var thirdHigh: UILabel!
    @IBOutlet weak var fourthHigh: UILabel!
    @IBOutlet weak var firstLow: UILabel!
    @IBOutlet weak var secondLow: UILabel!
    @IBOutlet weak var thridLow: UILabel!
    @IBOutlet weak var fourthLow: UILabel!
    @IBOutlet weak var firstRain: UILabel!
    @IBOutlet weak var secondRain: UILabel!
    @IBOutlet weak var thridRain: UILabel!
    @IBOutlet weak var fourthRain: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        whiteBackgroundLayer.layer.cornerRadius = 7

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  HourlySummaryCell.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/28/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit

class HourlySummaryCell: UITableViewCell {

    @IBOutlet weak var whiteBackgroundLayer: UIView!
    @IBOutlet weak var firstHour: UILabel!
    @IBOutlet weak var secondHour: UILabel!
    @IBOutlet weak var thridHour: UILabel!
    @IBOutlet weak var fourthHour: UILabel!
    @IBOutlet weak var firstTemp: UILabel!
    @IBOutlet weak var secondTemp: UILabel!
    @IBOutlet weak var thridTemp: UILabel!
    @IBOutlet weak var fourthTemp: UILabel!
    @IBOutlet weak var firstRain: UILabel!
    @IBOutlet weak var secondRain: UILabel!
    @IBOutlet weak var thirdRain: UILabel!
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

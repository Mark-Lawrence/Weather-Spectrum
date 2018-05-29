//
//  HourlyTableViewCell.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/12/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var chanceRainLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        animatedView.layer.opacity = 0.75
        animatedView.layer.cornerRadius = 7

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

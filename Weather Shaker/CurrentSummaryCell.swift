//
//  CurrentSummaryCell.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 6/28/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit

class CurrentSummaryCell: UITableViewCell {

    @IBOutlet weak var whiteBackgroundLayer: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    let uiColors = TextColor()
    
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

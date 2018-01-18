//
//  SettingsTableViewCell.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 7/9/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var whiteBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        whiteBackground.layer.cornerRadius = 7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

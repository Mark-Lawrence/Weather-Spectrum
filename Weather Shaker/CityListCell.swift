//
//  CityListCell.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 7/12/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit

class CityListCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

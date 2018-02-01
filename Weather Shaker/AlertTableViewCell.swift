//
//  AlertTableViewCell.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 1/19/18.
//  Copyright © 2018 Mark Lawrence. All rights reserved.
//

import UIKit

class AlertTableViewCell: UITableViewCell {

    @IBOutlet weak var labelWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var severity: UILabel!
    @IBOutlet weak var experationDate: UILabel!
    var url = ""
    @IBOutlet weak var scrollToDate: NSLayoutConstraint!
    
    @IBOutlet weak var scrollToSeverity: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        labelWidth.constant = (scrollView.frame.width - 9)
        scrollView.layer.cornerRadius = 5
        

    }
    
    @IBAction func didPressURL(_ sender: Any) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

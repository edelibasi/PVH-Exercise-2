//
//  ScheduleCell.swift
//  PVH Exercise 2
//
//  Created by Emre Delibasi on 9/13/17.
//  Copyright © 2017 PVH. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    static let reuseID = "ScheduleCell"
    static let nibName = "ScheduleCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setStartDate(_ startDate: Date) {
        startDateLabel.text = "Begin: " + startDate.stringValue
    }
    
    func setEndDate(_ endDate: Date) {
        endDateLabel.text = "End: " + endDate.stringValue
    }
}

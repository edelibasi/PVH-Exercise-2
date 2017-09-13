//
//  ScheduleDetailView.swift
//  PVH Exercise 1
//
//  Created by Emre Delibasi on 9/8/17.
//  Copyright © 2017 PVH. All rights reserved.
//

import UIKit

class ScheduleDetailView: UIView {

    let inputLabel = UILabel()
    let valueLabel = UILabel()
    var defaultValue = ""
    
    init(leftText: String) {
        inputLabel.text = leftText
        super.init(frame: .zero)
        
        addSubviews()
        customizeLabels()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup & Configuration
    func addSubviews() {
        self.addSubview(inputLabel)
        self.addSubview(valueLabel)
    }
    
    func customizeLabels() {
        inputLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        inputLabel.textColor = .black
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        inputLabel.sizeToFit()
        
        valueLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        valueLabel.textColor = .black
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.sizeToFit()
    }

    func setupConstraints() {
        let leftLabelVerticalConstraint = NSLayoutConstraint(item: inputLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let leftLabelHorizontalConstraint = NSLayoutConstraint(item: inputLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 30)
        
        let rightLabelVerticalConstraint = NSLayoutConstraint(item: valueLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let rightLabelHorizontalConstraint = NSLayoutConstraint(item: valueLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -30)
        
        self.addConstraints([leftLabelVerticalConstraint, leftLabelHorizontalConstraint, rightLabelVerticalConstraint, rightLabelHorizontalConstraint])
    }
    
    // MARK: - Helper Methods
    func setNewDefaultValue(_ defaultValue: String) {
        self.defaultValue = defaultValue
    }
    
    func resetValueLabel() {
        valueLabel.text = defaultValue
    }
}

//
//  ScheduleViewController.swift
//  PVH Exercise 2
//
//  Created by Emre Delibasi on 9/13/17.
//  Copyright © 2017 PVH. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    let datePicker = UIDatePicker()
    let beginDateView = ScheduleDetailView(leftText: "Begin:")
    let endDateView = ScheduleDetailView(leftText: "End Date:")

    var schedule = Schedule()
    var scheduleCallback: ((Schedule) -> Void)?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureDatePicker()
        configureDetailViews()
        configureNavigationBar()
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            self.scheduleCallback?(schedule)
        }
    }
    
    // MARK: - Setup & Configuration
    func configureDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(datePicker:)), for: .valueChanged)
        datePicker.setDate(schedule.beginDate, animated: true)
    }
    
    func configureDetailViews() {
        beginDateView.translatesAutoresizingMaskIntoConstraints = false
        beginDateView.setNewDefaultValue(schedule.beginDate.stringValue)
        beginDateView.valueLabel.text = beginDateView.defaultValue
        
        endDateView.translatesAutoresizingMaskIntoConstraints = false
        endDateView.setNewDefaultValue(schedule.endDate.stringValue)
        endDateView.valueLabel.text = endDateView.defaultValue
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)]
        navigationController?.navigationBar.topItem?.title = ScheduleVCStrings.title
        navigationController?.navigationBar.barStyle = .black
        
        let clearButton = UIBarButtonItem(title: ScheduleVCStrings.clear, style: .plain, target: self, action: #selector(clearPressed))
        navigationItem.rightBarButtonItem = clearButton
    }
    
    func addSubviews() {
        view.addSubview(beginDateView)
        view.addSubview(datePicker)
        view.addSubview(endDateView)
    }
    
    func setupConstraints() {
        let startDateLeadingConstraint = NSLayoutConstraint(item: beginDateView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let startDateTrailingConstraint = NSLayoutConstraint(item: beginDateView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let startDateTopConstraint = NSLayoutConstraint(item: beginDateView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        let startDateHeightConstraint = NSLayoutConstraint(item: beginDateView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: LayoutConstants.detailViewHeight)
        
        let datePickerLeadingConstraint = NSLayoutConstraint(item: datePicker, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let datePickerTrailingConstraint = NSLayoutConstraint(item: datePicker, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let datePickerTopConstraint = NSLayoutConstraint(item: datePicker, attribute: .top, relatedBy: .equal, toItem: beginDateView, attribute: .bottom, multiplier: 1, constant: 0)
        let datePickerHeightConstraint = NSLayoutConstraint(item: datePicker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: LayoutConstants.datePickerHeight)
        
        let endDateLeadingConstraint = NSLayoutConstraint(item: endDateView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let endDateTrailingConstraint = NSLayoutConstraint(item: endDateView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let endDateTopConstraint = NSLayoutConstraint(item: endDateView, attribute: .top, relatedBy: .equal, toItem: datePicker, attribute: .bottom, multiplier: 1, constant: 0)
        let endDateHeightConstraint = NSLayoutConstraint(item: endDateView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: LayoutConstants.detailViewHeight)
        
        self.view.addConstraints([startDateLeadingConstraint, startDateTrailingConstraint, startDateTopConstraint, startDateHeightConstraint, datePickerLeadingConstraint, datePickerTrailingConstraint, datePickerTopConstraint, datePickerHeightConstraint, endDateLeadingConstraint, endDateTrailingConstraint, endDateTopConstraint, endDateHeightConstraint])
    }
    
    // MARK: - Actions & Helper Methods
    func clearPressed() {
        datePicker.setDate(Date(), animated: true)
        beginDateView.valueLabel.text = beginDateView.defaultValue
        endDateView.valueLabel.text = endDateView.defaultValue
    }
    
    func datePickerValueChanged(datePicker: UIDatePicker) {
        let startDateString = datePicker.date.stringValue
        let endDateString = datePicker.date.addingDays(7).stringValue
        
        schedule.beginDate = datePicker.date
        schedule.endDate = datePicker.date.addingDays(7)
        
        beginDateView.valueLabel.text = startDateString
        endDateView.valueLabel.text = endDateString
    }
}

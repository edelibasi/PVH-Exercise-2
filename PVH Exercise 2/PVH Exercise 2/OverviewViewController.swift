//
//  ViewController.swift
//  PVH Exercise 2
//
//  Created by Emre Delibasi on 9/13/17.
//  Copyright © 2017 PVH. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var schedules = [Schedule]()
    let addScheduleSegueID = "addScheduleSegue"
    let showScheduleSegueID = "showScheduleSegue"
    let scheduleCellReuseID = "ScheduleCell"

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
    }
    
    // MARK: - Setup & Configuration
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)]
        navigationController?.navigationBar.topItem?.title = "Overview"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: scheduleCellReuseID)
        tableView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: scheduleCellReuseID)
        tableView.tableFooterView = UIView()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scheduleVC = segue.destination as? ScheduleViewController, let identifier = segue.identifier {
            
            switch(identifier) {
            case addScheduleSegueID:
                scheduleVC.scheduleCallback = { schedule in
                    self.schedules.append(schedule)
                    self.tableView.reloadData()
                }
            case showScheduleSegueID:
                if let indexPath = sender as? IndexPath {
                    scheduleVC.schedule = schedules[indexPath.row]
                    scheduleVC.scheduleCallback = { schedule in
                        self.schedules[indexPath.row] = schedule
                        self.tableView.reloadData()
                    }
                }
            default: break
            }
        }
    }
}

extension OverviewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: showScheduleSegueID, sender: indexPath)
    }
}

extension OverviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: scheduleCellReuseID, for: indexPath) as? ScheduleCell else {
            return UITableViewCell()
        }
        
        cell.setStartDate(schedules[indexPath.row].startDate)
        cell.setEndDate(schedules[indexPath.row].endDate)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
}



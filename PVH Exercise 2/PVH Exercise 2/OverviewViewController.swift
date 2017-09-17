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
        navigationController?.navigationBar.topItem?.title = OverviewVCStrings.title
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.reuseID)
        tableView.register(UINib(nibName: ScheduleCell.nibName, bundle: nil), forCellReuseIdentifier: ScheduleCell.reuseID)
        tableView.tableFooterView = UIView()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scheduleVC = segue.destination as? ScheduleViewController, let identifier = segue.identifier {
            
            switch(identifier) {
            case OverviewVCStrings.addScheduleSegueID:
                scheduleVC.scheduleCallback = { schedule in
                    self.schedules.append(schedule)
                    self.synchronizeTableView()
                }
            case OverviewVCStrings.showScheduleSegueID:
                if let indexPath = sender as? IndexPath {
                    scheduleVC.schedule = schedules[indexPath.row]
                    scheduleVC.scheduleCallback = { schedule in
                        self.schedules[indexPath.row] = schedule
                        self.synchronizeTableView()
                    }
                }
            default: break
            }
        }
    }
    
    // MARK: - Helpers
    func synchronizeTableView() {
        schedules = schedules.sorted(by: { $0.beginDate < $1.beginDate })
        self.tableView.reloadData()
    }
}

extension OverviewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: OverviewVCStrings.showScheduleSegueID, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            schedules.remove(at: indexPath.row)
            synchronizeTableView()
        }
    }
}

extension OverviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseID, for: indexPath) as? ScheduleCell else {
            return UITableViewCell()
        }
        
        cell.setStartDate(schedules[indexPath.row].beginDate)
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



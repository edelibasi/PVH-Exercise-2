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
    let scheduleSegueID = "showScheduleSegue"

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    // MARK: - Setup & Configuration
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)]
        navigationController?.navigationBar.topItem?.title = "Overview"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scheduleVC = segue.destination as? ScheduleViewController, segue.identifier == scheduleSegueID {
            scheduleVC.scheduleCallback = { schedule in
                self.schedules.append(schedule)
                print(schedule)
            }
        }
    }
}


//
//  TeacherAttendanceViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/25/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class TeacherAttendanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    //properties for data
    var tableData = []
    var tableView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //create and place tableview
        let tFrame = self.view.bounds
        let tableView = UITableView(frame: tFrame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0)
        self.view.addSubview(tableView)
        self.tableView = tableView
    }
    
    //update view title each time the view is in focus
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.title = "Attendance"
    }
    
    
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        //number of rows in the tableView section
        return self.tableData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        //create reusable cell and populate data
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")

        //populate data to cell from db here
        
        return cell
    }

}

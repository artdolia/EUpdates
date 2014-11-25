//
//  ParentAttendanceViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/25/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class ParentAttendanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //properties to manipulate the data
    var tableData = []
    var tableView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create and place the tableview
        let tFrame = self.view.bounds
        let tableView = UITableView(frame: tFrame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0)
        self.view.addSubview(tableView)
        self.tableView = tableView
    }
    
    //update the view title each time the view is in the focus
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.title = "Attendance"
    }
    
    
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        //number of the rows in tableview section
        return self.tableData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        //create a reusable cell and populate data
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")

        //the data from database supposed to be used here to update the cell content
        //the implementation is similar to viewing updates
        
        return cell
    }

}

//
//  TeacherFeedbackViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/25/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class TeacherFeedbackViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //properties for data manipulation
    var tableData = []
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //create and place tableView
        let tFrame = self.view.bounds
        let tableView = UITableView(frame: tFrame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0)
        self.view.addSubview(tableView)
        self.tableView = tableView
        
        //get the data from db
        fetchJson()
    }
    
    //update view title each time the view is in focus
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.title = "Feedback"
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        //number of rows in tableview section
        return self.tableData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        //create reusable cell and populate with data
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        var fields: NSDictionary = rowData["fields"] as NSDictionary
        var updateText:NSString = fields["feedbackText"] as NSString
        cell.textLabel.text = updateText
        
        return cell
    }
    
    //MARK: JSON
    
    func fetchJson(){

        
        let urlPath = "http://ec2-54-68-187-75.us-west-2.compute.amazonaws.com/feedback/json/"
        
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        
        //initialize task with url and session
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            println("Task completed")
            
            if error != nil {
                println(error.localizedDescription)
            }
            
            var err: NSError?
            
            //store the result in array
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
            
            if(err != nil){
                
                println("JSON Error \(err!.localizedDescription) ")
            }
            dispatch_async(dispatch_get_main_queue(), {
                
                self.tableData = jsonResult
                self.tableView!.reloadData()
            })
        })
        
        task.resume()
    }
}

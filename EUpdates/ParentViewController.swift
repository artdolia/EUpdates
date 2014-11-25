//
//  ParentViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/17/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //properties for the ui and data elements
    @IBOutlet weak var activityHeaderLabel: UILabel!
    var tableData = []
    var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        //set the title of the view
        self.tabBarController?.title = "Updates"
        
        //create table and place tableview
        let tFrame = self.view.bounds
        let tableView = UITableView(frame: tFrame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0)
        self.view.addSubview(tableView)
        self.tableView = tableView
        
        //get the data from db with json
        fetchJson()
    }
    
    
    //need this to update view title each time the user change tabs
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.title = "Updates"
    }
    
    //MARK: UITableViewDataSource
    //the mthods required to conform to the data source protocol
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //number of the rows in tableview
        return self.tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        //create reusable cell and populate with data
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        var fields: NSDictionary = rowData["fields"] as NSDictionary
        var updateText:NSString = fields["updateText"] as NSString
        var updateTime:NSString = fields["updateTime"] as NSString
        cell.textLabel.text = updateText
        cell.detailTextLabel?.text = updateTime
        
        return cell
    }
    
    
    //use segue to navigate to the update details view when the row is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.setSelected(false, animated: true)
        self.performSegueWithIdentifier("updateToDetails", sender: self)
    }
    
    
    //MARK: JSON
    
    func fetchJson(){
        
        let urlPath = "http://ec2-54-68-187-75.us-west-2.compute.amazonaws.com/updates/json/"
        
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        
        //start task with url and session
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            println("Task completed")
            
            if error != nil {
                println(error.localizedDescription)
            }
            
            var err: NSError?
            
            //get the result as array
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
            
            if(err != nil){
                
                println("JSON Error \(err!.localizedDescription) ")
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                //populate the data to the tableview
                self.tableData = jsonResult
                self.tableView!.reloadData()
            })
        })
        
        task.resume()
    }
    
    
    //the method is to pass the data to the next view when the seque is executed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "updateToDetails" {
            
            //prepare data array to pass
            let selectedRowIndex = self.tableView!.indexPathForSelectedRow()!.row
            let selectedRowDict = self.tableData[selectedRowIndex] as NSDictionary
            let selectedField = selectedRowDict["fields"] as NSDictionary
            var updateText:NSString = selectedField["updateText"] as NSString
            var updateTime:NSString = selectedField["updateTime"] as NSString
            let arrayToPass = [updateTime, updateText]
            
            //get the destination view controller and pass the array
            let destinationViewController: UpdateDetailsViewController = segue.destinationViewController as UpdateDetailsViewController
            
            //set the property of the destination viewController
            destinationViewController.cellDataReceived = arrayToPass
            
        }
    }
}
